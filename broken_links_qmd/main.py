import requests
import os
import re
import logging

from pathlib import Path, PurePath
from datetime import datetime

# Configuration
SCRIPT_FOLDER = os.path.dirname(os.path.realpath(__file__))  # Path to the folder containing the script
PROJECT_FOLDER = Path(SCRIPT_FOLDER).parent  # Root project folder, parent of the scripts folder
LOG_LEVEL = logging.INFO

RESULT_LOG_FILE_SUFFIX = datetime.now().strftime("%Y%m%dT%H%M")
LOG_FILE = os.path.join(SCRIPT_FOLDER, f"Result_{RESULT_LOG_FILE_SUFFIX}.log")  # Main log file with the current date and time in the script folder
ERROR_LOG_FILE = os.path.join(SCRIPT_FOLDER, f"errors_{RESULT_LOG_FILE_SUFFIX}.log")  # Error log file

# Modified pattern to find all links in QMD files, specifically targeting broken Markdown URLs
HREF_PATTERN = r"(?P<url>https?://[^\s\)'<\"]+)"  # Adjusted regex to avoid capturing incomplete URLs

HTTP_HEADERS = {
    "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36",
}

# To store problematic URLs (timeouts, 404s, etc.)
problematic_urls = []

def init_environment() -> None:
    # Set up the main log file
    logging.basicConfig(
        level=LOG_LEVEL,
        format="%(asctime)s [%(levelname)s] %(message)s",
        handlers=[
            logging.FileHandler(LOG_FILE),
            logging.StreamHandler()
        ]
    )

    # Set up a second logger for the error log
    error_logger = logging.getLogger("error_log")
    error_logger.setLevel(logging.WARNING)
    error_handler = logging.FileHandler(ERROR_LOG_FILE)
    error_handler.setFormatter(logging.Formatter("%(asctime)s [%(levelname)s] %(message)s"))
    error_logger.addHandler(error_handler)

    return error_logger

def clean_url(url: str) -> str:
    """Clean and ensure URL is well-formed, fixing broken Markdown URLs."""
    url = re.sub(r"\]\(", "", url)  # Remove improper markdown link parts
    url = re.split(r"https?://", url)  # Split on 'http://' or 'https://'
    if len(url) > 2:
        url = "https://" + url[1]  # Keep only the first complete URL after splitting
    else:
        url = "https://" + url[1] if len(url) > 1 else url[0]  # Reconstruct the URL
    
    url = url.strip().replace("-->", "")  # Clean out extraneous comment endings
    
    # Make sure it does not contain markdown remnants
    url = re.sub(r"\[(.*?)\]", "", url)  # Remove the content between any [ ] brackets
    
    return url


def check_url(url: str, file_name: str, line: int, error_logger) -> None:
    """Checks a single URL for broken links and logs the result."""
    blocked_urls = ['example_blocked_site.com']  # Add known blocked URLs here

    cleaned_url = clean_url(url)  # Clean the URL to fix any malformed Markdown issues

    if any(blocked in cleaned_url for blocked in blocked_urls):
        logging.warning(f"BLOCKED | {file_name} | Line {line} | {cleaned_url}")
        problematic_urls.append(f"BLOCKED | {file_name} | Line {line} | {cleaned_url}")
        error_logger.warning(f"BLOCKED | {file_name} | Line {line} | {cleaned_url}")
        return  # Skip known blocked URLs to avoid false positives

    try:
        r = requests.get(cleaned_url, headers=HTTP_HEADERS, timeout=10)

        if r.status_code >= 200 and r.status_code < 300:
            logging.info(f"{r.status_code} | {file_name} | Line {line} | {cleaned_url}")
        elif r.status_code == 429:
            logging.warning(f"RATE_LIMITED | {file_name} | Line {line} | {cleaned_url}")
            problematic_urls.append(f"RATE_LIMITED | {file_name} | Line {line} | {cleaned_url}")
            error_logger.warning(f"RATE_LIMITED | {file_name} | Line {line} | {cleaned_url}")
        elif r.status_code >= 300 and r.status_code < 400:
            logging.warning(f"{r.status_code} | {file_name} | Line {line} | {cleaned_url}")
        else:
            logging.error(f"{r.status_code} | {file_name} | Line {line} | {cleaned_url}")
            problematic_urls.append(f"{r.status_code} | {file_name} | Line {line} | {cleaned_url}")
            error_logger.error(f"{r.status_code} | {file_name} | Line {line} | {cleaned_url}")

    except requests.exceptions.Timeout:
        logging.error(f"TIMEOUT | {file_name} | Line {line} | {cleaned_url}")
        problematic_urls.append(f"TIMEOUT | {file_name} | Line {line} | {cleaned_url}")
        error_logger.error(f"TIMEOUT | {file_name} | Line {line} | {cleaned_url}")
    except requests.exceptions.RequestException as e:
        logging.error(f"ERROR | {file_name} | Line {line} | {cleaned_url} | {str(e)}")
        problematic_urls.append(f"ERROR | {file_name} | Line {line} | {cleaned_url} | {str(e)}")
        error_logger.error(f"ERROR | {file_name} | Line {line} | {cleaned_url} | {str(e)}")

def check_file(file: str, error_logger) -> None:
    """Checks all URLs in a given QMD file."""
    checked_urls = set()  # This stores the URLs that have already been checked
    with open(file, "r", encoding="utf8", errors="ignore") as qmd_file:
        for line_number, line in enumerate(qmd_file, 1):
            for match in re.finditer(HREF_PATTERN, line):
                url = match.group("url")
                if url:
                    url = url.strip()  # Remove extra spaces from the URL
                    if url not in checked_urls:  # Check if the URL hasn't been checked yet
                        checked_urls.add(url)
                        check_url(url, PurePath(file).name, line_number, error_logger)

def log_problematic_urls_at_end() -> None:
    """Logs all problematic URLs at the end of the main log file."""
    if problematic_urls:
        with open(LOG_FILE, "a") as log_file:
            log_file.write("\n\n# Problematic URLs (Errors, Timeouts, Blocked) #\n")
            for entry in problematic_urls:
                log_file.write(f"{entry}\n")

def main() -> None:
    error_logger = init_environment()

    for file in Path(PROJECT_FOLDER).rglob("*.qmd"):  # Searches for all QMD files in the folder
        check_file(file, error_logger)

    log_problematic_urls_at_end() 
    print("Done!") 

if __name__ == "__main__":
    main()

"""
This script checks all links in all RMD files in a folder (and its subfolders) for broken links
and logs the results in a log file. It has been modified to work with knitr links in RMD files.

RMD_FOLDER - line 20 -> Path(SCRIPT_FOLDER).parent # path to the folder containing the RMD files
                                                    # which is one folder up from the script folder

Note:
I advise you to check the ERROR fields in the log file, if they are still valid.
Because some websites implement rate limiting, block requests from automated scripts, or implement other security measures to prevent server overload or abuse.
"""

import requests
import os
import re
import logging

from pathlib import Path, PurePath
from datetime import datetime

# Configuration
SCRIPT_FOLDER = os.path.dirname(os.path.realpath(__file__))  # Path to the folder containing the script
RMD_FOLDER = Path(SCRIPT_FOLDER).parent  # Path to the folder containing the RMD files
LOG_LEVEL = logging.INFO

RESULT_LOG_FILE_SUFFIX = datetime.now().strftime("%Y%m%dT%H%M")
LOG_FILE = os.path.join(SCRIPT_FOLDER, f"Result_{RESULT_LOG_FILE_SUFFIX}.log")  # Log file with the current date and time in the script folder

# Modified pattern to find all links in RMD files (including knitr links)
HREF_PATTERN = r"(?P<url>https?://[^\s\)'<\"]+(?!</a>))|\bknitr::include_url\([\"'](?P<knitr_url>https?://[^\s\"']+)[\"']\)"

HTTP_HEADERS = {
    "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36",
}

def init_environment() -> None:
    logging.basicConfig(
        level=LOG_LEVEL,
        format="%(asctime)s [%(levelname)s] %(message)s",
        handlers=[
            logging.FileHandler(LOG_FILE),
            logging.StreamHandler()
        ]
    )

def check_url(url: str, file_name: str, line: int) -> None:
    """Checks a single URL for broken links."""
    if "realpython.com" in url:
        logging.warning(f"429 | {file_name} | Line {line} | {url}")
        return  # Skips realpython.com links -> becuase of 416 .. 

    try:
        r = requests.get(url, headers=HTTP_HEADERS)

        if r.status_code >= 200 and r.status_code < 300:
            logging.info(f"{r.status_code} | {file_name} | Line {line} | {url}")
        elif r.status_code >= 300 and r.status_code < 400:
            logging.warning(f"{r.status_code} | {file_name} | Line {line} | {url}")
        else:
            logging.error(f"{r.status_code} | {file_name} | Line {line} | {url}")

    except:
        logging.error(f"ERROR | {file_name} | Line {line} | {url}")

def check_file(file: str) -> None:
    checked_urls = set() # This line checks the stored urls.
    with open(file, "r", encoding="utf8", errors="ignore") as rmd_file:
        for line_number, line in enumerate(rmd_file, 1):
          for match in re.finditer(HREF_PATTERN, line):
              url = match.group("url") or match.group("knitr_url")  # If the link is a knitr link, it will be found in the knitr_url group
              if url:
                  url = url.strip() # Strip the URL to remove any extra whitespace ..
                  if url not in checked_urls: # Check if the URL is not already checked ...
                    checked_urls.add(url) # Add the URL to the set of checked URLs
                    check_url(url, PurePath(file).name, line_number)

def main() -> None:
    init_environment()

    for file in Path(RMD_FOLDER).rglob("*.Rmd"):  # Searches for all RMD files in the RMD folder
        check_file(file)

if __name__ == "__main__":
    main()

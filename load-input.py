import os
import sys
from dotenv import load_dotenv
import requests
load_dotenv()
session = os.getenv("SESSION")
day = sys.argv[1]
with open(f"./day{day}/input", "w") as f:
    f.write(str(requests.get(f"https://adventofcode.com/2024/day/{day}/input", cookies={"session":session}).content).replace("\\n","\n")[2:-2])
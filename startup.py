import pprint
import sys

sys.ps1 = "\033[0;34m>>> \033[0m"
sys.ps2 = "\033[1;34m... \033[0m"
sys.displayhook = pprint.pprint

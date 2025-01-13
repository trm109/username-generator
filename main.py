import random
import argparse
from timeit import default_timer as timer


parser = argparse.ArgumentParser(description="Generate greetings for name combinations")
# Parse arguments
parser.add_argument(
    "-c",
    "--char_limit",
    dest="char_limit",
    type=int,
    help="Character limit for each combination",
    default=100,
)
parser.add_argument(
    "-g",
    "--greetings",
    dest="greetings",
    type=str,
    help="Path to text file containing greetings",
    default="input/greetings.txt",
)
parser.add_argument(
    "-f",
    "--first_names",
    dest="first_names",
    type=str,
    help="Path to text file containing first names",
    default="input/first_names.txt",
)
parser.add_argument(
    "-l",
    "--last_names",
    dest="last_names",
    type=str,
    help="Path to text file containing last names",
    default="input/last_names.txt",
)
parser.add_argument(
    "-o",
    "--output",
    dest="output",
    type=str,
    help="Path to output file",
    default="output/combinations.txt",
)
parser.add_argument(
    "-s",
    "--shuffle",
    dest="shuffle",
    type=bool,
    help="Shuffle the output",
    default=True,
)

# Parse arguments
args = parser.parse_args()

# Read all the files
try:
    with open(args.greetings) as f:
        greetings = f.readlines()
except FileNotFoundError:
    print("Greetings file not found")

try:
    with open(args.first_names) as f:
        first_names = f.readlines()
except FileNotFoundError:
    print("First names file not found")

try:
    with open(args.last_names) as f:
        last_names = f.readlines()
except FileNotFoundError:
    print("Last names file not found")

# Start generating combinations
combinations = []
print("Generating combinations...")
# Start timer (for funsies)
time_start = timer()
for f in first_names:
    # Only consider names that are less than the character limit
    for l in [x for x in last_names if len(x) + len(f) <= args.char_limit]:
        # Randomly select a greeting
        g = random.choice(greetings)
        # Check if the name can fit a space between the first and last name
        # If not, then don't add a space. Ex; JohnDoe if char_limit is 7
        space = " " if len(l) + len(f) < args.char_limit else ""
        combinations.append(g.strip() + ", " + f.strip() + space + l.strip())
        # print('\n' + g.strip() + ', ' + bcolors.OKCYAN + f.strip() + space + l.strip() + bcolors.ENDC)

# Shuffle the combinations before writing to file
if args.shuffle:
    random.shuffle(combinations)
# print time, rounded to 10 decimal points
time_end = timer()
print(
    f"Generated {len(combinations)} combinations in {time_end - time_start:.10f} seconds"
)
# write to file
try:
    with open(args.output, "w") as f:
        for item in combinations:
            f.write("%s\n" % item)
    print("Output written to " + args.output)
except IOError:
    print("Error writing output file")
# EOF :)

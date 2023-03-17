from os.path import isdir, expanduser
import sys
from typing import NoReturn, Optional, Sequence, Union, Callable
from pathlib import Path
import itertools
from fnmatch import fnmatch
import time

def warn(msg: str) -> None:
    print(f"{sys.argv[0]}: {msg}", file=sys.stderr)
        
def die(msg: str) -> NoReturn:
    warn(msg)
    sys.exit(1)
    
home_dir = expanduser("~")
name_file = f"{home_dir}/.named-dirs"
    
def named_dir(word: str) -> Optional[str]:
    if word.startswith(".") or "/" in word:
        return None
    with open(name_file, "r") as file:
        for pair in file:
            abbr, target = pair.split(maxsplit=1)
            if word.lower() == abbr.lower():
                return target.rstrip()+"/"
    return None

def split_words(words: Sequence[str], *, test: Union[str, Callable[[str], bool]] = "/" ) -> Sequence[Sequence[str]]:
    if isinstance(test, str):
        delimiter = test
        test = lambda s: s == delimiter
    check = test
    seqs = [
        [x for _i, x in group]
        for key, group in itertools.groupby(enumerate(words), lambda x: check(x[1]))
        if not key
        ]
    return seqs


def add_matches(in_dir: Path, segments: Sequence[Sequence[str]], results: set[Path]) -> None:
    if len(segments) == 0:
        results.add(in_dir)
        return
    first, *rest = segments
    pattern = f"*{'*'.join(first)}*".lower()
    subdirs = { d.name.lower(): d for d in in_dir.iterdir() if isdir(d)}
    next_level = list[Path]()
    for n,d in subdirs.items():
        if fnmatch(n, pattern):
            next_level.append(d)
    for d in next_level:
        add_matches(d, rest, results)


def matches(in_dir: Optional[Union[Path, str]], words: Sequence[str]) -> set[Path]:
    if in_dir is None:
        return set()
    if isinstance(in_dir, str):
        in_dir = Path(in_dir)
    segments = split_words(words)
    results = set[Path]()
    add_matches(in_dir, segments, results)
    return results
    
def pick_best(paths: set[Path]) -> tuple[Optional[Path], Sequence[Path]]:
    if len(paths) == 0:
        return (None, ())
    as_list = sorted(paths, key=lambda p: p.stat().st_mtime, reverse=True)
    best = None if len(as_list) == 0 else as_list[0]
    as_list.sort(key=lambda p: p.name)
    return (best, as_list)

def find_dir(words: Sequence[str]) -> tuple[Optional[Path], Sequence[Path]]:
    first, *rest = words
    target = named_dir(first)
    if target is not None:
        dirs = matches(target, rest)
        if len(dirs) > 0:
            return pick_best(dirs)
    dirs = matches(".", words)
    return pick_best(dirs)
    

args = sys.argv[1:]

if len(args) == 0:
    die("No files specified")

target, choices = find_dir(args)
if target is None:
    die(f"No directory matches '{' '.join(args)}'")
if len(choices) > 1:
    others = [s for s in choices if s != target]
    # print(others)
    as_string = '\n  '.join(str(p) for p in others)
    # print(as_string)
    warn(f"Could also have been:\n  {as_string}")

print(target)

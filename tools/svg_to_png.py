from pathlib import Path
import os
import sys
import shutil
import subprocess
import cairosvg


def make_output_path(in_path: Path, overwrite: bool = True) -> Path:
    stem = in_path.stem
    name = f"{stem}.png"
    out_path = in_path.with_name(name)
    return out_path


def convert(in_path: Path, out_path: Path, **kwargs) -> None:
    default_kwargs = {"dpi": 400, "scale": 1}
    kwargs = default_kwargs | kwargs
    with in_path.open("rb") as f:
        cairosvg.svg2png(file_obj=f, write_to=out_path.as_posix(), **kwargs)


def main():
    for possible_path in sys.argv[1:]:
        try:
            path = Path(possible_path).resolve(strict=True)
            if not path.is_file():
                continue
            convert(in_path=path, out_path=make_output_path(path))
        except FileNotFoundError as e:
            print(e)


if __name__ == '__main__':
    main()

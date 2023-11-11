from scipy.stats import norm
from typing import Tuple

def expected_captures_for_decade(start: int, end: int, mean: float, std_dev: float, total_captures: int) -> float:
    cdf_start = norm.cdf(start, mean, std_dev)
    cdf_end = norm.cdf(end, mean, std_dev)
    return total_captures * (cdf_end - cdf_start)

mean = 225
std_dev = 45
total_captures = 250

# Let's calculate for decades from 100 to 350, stepping by 10
for start in range(100, 351, 10):
    end = start + 10
    captures = expected_captures_for_decade(start, end, mean, std_dev, total_captures)
    print(f"Expected captures from {start}-{end} years: {captures:.2f}")

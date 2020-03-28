# Clockout
An aid in text-based time logging

## Installation
Make sure clockout.bash has executable permission. If this not possible, you can run it by calling bash first.

Dependencies:
- bash
- egrep
- bc
- units

## Usage
A text-based inputfile is expected according to the following format:
```
ABC-1           09:00   09:10
DEF-1           09:10   09:20
ABC-1           09:35   10:55
```
Any type and amount of whitespace characters are allowed, as long as there are three columns on each line. Empty lines are not allowed.

Running the program from CLI:
`./clockout.bash <inputfile>`

The output of the above sample would look like:
```
ABC-1				09:00	09:10	10
ABC-1				09:35	10:55	80
└ Subtotal: 90

DEF-1				09:10	09:20	10

Total: 	1 hr + 40 min
```

The calculated timesheet is outputted to Stdout, if dependencies are met and the inputfile conforms to the expected format. The output can be piped to another file, if desired.

## Possible improvements

- Add tests
- Support comments
- Add a test for timelog overlap

## Contributing

Feel free to open an issue or a pull request.


## License

[MIT](https://choosealicense.com/licenses/mit/)

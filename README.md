# Clockout
An aid in text-based time logging

## Installation
Make sure clockout.bash has executable permission set. If this is not possible, you can run it by calling it from bash.

Dependencies:
- bash
- bc
- egrep
- units

## Usage
A text-based inputfile is expected according to the following format (example):
```
ABC-1           09:00   09:10
DEF-1           09:10   09:20   Urgent call
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

DEF-1				09:10	09:20	10	Urgent call

Total: 	1 hr + 40 min
```

If the dependencies are met and the inputfile conforms to the expected format, then the calculated timesheet is outputted to Stdout. The output can be piped to another file, if desired.

## Possible improvements

- Add tests for the program itself
- Add a test for timelog overlap

## Contributing

Feel free to open an issue or a pull request.


## License

[MIT](https://choosealicense.com/licenses/mit/)

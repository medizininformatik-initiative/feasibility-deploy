Make sure that password files neither have a trailing newline nor a carriage return.

To avoid this situation make sure to write password files using:
```
echo -n "foo" > file.password
```

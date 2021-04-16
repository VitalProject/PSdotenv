# PSdotenv

This script is used for loading environment variables into your powershell script.
It does so by parsing a txt file by line and then separating variables from values via a '=' delimiter

# Getting started

Any text file type is usuable but we suggest giving the file a .env extension
In the file put one variable per line using the following syntax
```VariableName=value```

Within your script you can use the function like
```$(.env "VariableName")``` 
Which would return the value



/**
 * The Actionscript Byte Code eXecutable translation tool for MacOS X
 *
 * @author      Copyright (c) 2008 daoki2
 * @version     1.0.0
 * @link        http://snippets.libspark.org/
 * @link        http://homepage.mac.com/daoki2/
 *
 * Copyright (c) 2008 daoki2
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import avmplus.System;

var args:Array = System.argv;

if (args.length != 1) {
    trace('Usage: abcx filename.abc');
} else {
    var code:String = new Array(
				"#include <stdlib.h>",
				"#include <stdio.h>",
				"#include <string.h>",
				"",
				"int main(int argc, char *argv[])",
				"{",
				"    static const char cmd[] = \"avmplus " + args[0] + "\";",
				"    int len = 0;",
				"    int i = 0;",
				"    char *args;",
				"    if (argc > 1) {",
				"        for (i = 1; i < argc; i++) {",
				"            len += strlen(argv[i]);",
				"        }",
				"        len += argc + 2 + strlen(cmd);",
				"        args = malloc(len + argc + 4 + strlen(cmd));",
				"        strcpy(args, cmd);",
				"        strcat(args, \" -- \");",
				"        for (i = 1; i < argc; i++) {",
				"            strcat(args, argv[i]);",
				"            strcat(args, \" \");",
				"        }",
				"    } else {",
				"        args = malloc(strlen(cmd));",
				"        strcpy(args, cmd);",
				"    }",
				"    system(args);",
				"}"
				).join("\n");
    trace(code);
}    

 
  while(!WScript.StdIn.AtEndOfStream)
  {
    var str = WScript.StdIn.ReadLine();
    WScript.StdOut.WriteLine(str);
    WScript.StdErr.WriteLine(str);
  }
 
# Nestedness
Software for performing nestedness analyses on microbial communities.

This software computes the nestedness between pairs of microbial communities. High nestedness can be indicative of ordered extinctions, ordered colonizations, nested habitats, and other ecological processes. Nestedness contrasts with modularity (replacement) between communities. 

## Dependencies
This software requires Java Runtime Environment (JRE) version 1.6 or greater. On many Apple systems, even if JRE 1.6 or greater is installed, the default version for running applications may be 1.5. The Java version can be checked by typing 'java -version' into a terminal. If an updated version is installed but is not being used, a few updates will need to be made; namely you might try typing the following commands in a terminal:

<pre><code>
sudo rm /usr/bin/java
sudo ln -s /Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home/bin/java /usr/bin
</code></pre>

Additional information on correcting the Java version can be found here: http://stackoverflow.com/questions/12757558/installed-java-7-on-mac-os-x-but-terminal-is-still-using-version-6.


# Activity watchdog

<p>
Created by: Nahúm Manuel Martín Vegas                             <br>
URL: https://github.com/nadamas2000/activity-watchdog             <br>
Version: V1                                                       <br>
Date: 03-dec-2019                                                 <br>
Developed in:                                                     <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Facultat d'informàtica de Barcelona (FIB)           <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Universitat Politécnica de Catalunya (UPC)          <br>
</p>
<p>
Project name: Activity-watchdog for Raspberry Pi (Raspbian linux) <br>
Project files: <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  activity-watchdog.sh                        <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  activity-watchdog.conf                      <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  software-watchdog.shlib                     <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  idle-watchdog.shlib                         <br>
Dependecies: <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  bash <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  procps                                              <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  coreutils                                           <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  xprintidle (only for idle-watchdog function)        <br>
</p>
<p>&nbsp;</p>

This is a shell script for Linux written for Bash.

<p>
For continuous execution you can use Cron by writing this instruction in a terminal session:<br>
&nbsp;&nbsp;&nbsp;&nbsp;<b> /> sudo crontab -e </b><br>
Add the execution line where "DIR-SOFTWARE" is the path to which your shell files are downloaded.<br>
&nbsp;&nbsp;&nbsp;&nbsp;<b> @reboot /"DIR-SOFTWARE"/activity-watchdog.sh</b><br>
</p>

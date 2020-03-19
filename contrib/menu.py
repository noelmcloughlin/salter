#!/usr/bin/env python
##########################################################
# Copyright (c) 2019 Saltstack Formulas
##########################################################
# encoding: utf-8
# This script displays a formula menu for default profile.
# http://npyscreen.readthedocs.org/introduction.html

try:
    import sys, os, platform, subprocess
except ImportError("Cannot import sys, os, platform, subprocess, modules"):
    exit(100)
try:
    import npyscreen
except ImportError("Cannot import npyscreen"):
    exit(102)

class TestApp(npyscreen.NPSApp, outdir='/srv/salt'):
    def __init__(self):
        self.dir = outdir
        # Set option users will see in the multi select widget
        self.maven = 'Maven'
        self.postgres = 'Postgres'
        self.java = 'Oracle JDK8 / JCE'
        self.tomcat = 'Tomcat7'
        self.apache = 'Apache (after install do not use port 80)'
        self.intellij = 'Intellij IDEA latest'
        self.pycharm = 'Pycharm latest'
        self.eclipse = 'Eclipse IDE latest'
        self.sqlplus = 'SQLPlus recent'
        self.sqldeveloper = 'SQL Developer recent'
        
    def main(self):
        # Create form
        F  = npyscreen.Form(name = "Example Linux Developer profile:",)
        # Create multi select widget on form
        multi_select = F.add(npyscreen.TitleMultiSelect, max_height =-2, value = [], name="Select Components",
                values = [
                          self.maven,
                          self.postgres,
                          self.java,
                          self.tomcat,
                          self.apache,
                          self.intellij,
                          self.pycharm,
                          self.eclipse,
                          self.sqlplus,
                          self.sqldeveloper], scroll_exit=True)
        # Allow users to interact with form
        F.edit()
        self.selection = multi_select.get_selected_objects()
        self.write_top()

    def write_top(self):
        # Map selected options to salt states
        select_list = []
        for item in self.selection:

            if item == self.maven:
                select_list.append('maven')
                select_list.append('maven.env')
            if item == self.postgres:
                select_list.append('postgres')
                select_list.append('postgres.server.image')
            if item == self.java:
                select_list.append('sun-java')
                #select_list.append('sun-java.jce')
                select_list.append('sun-java.env')
            if item == self.tomcat:
                select_list.append('tomcat')
                select_list.append('tomcat.config')
                select_list.append('tomcat.native')
                select_list.append('tomcat.manager')
            if item == self.apache:
                select_list.append('apache')
                select_list.append('apache.config')
                select_list.append('apache.certificates')
                select_list.append('apache.mod_mpm')
                select_list.append('apache.modules')
                select_list.append('apache.mod_rewrite')
                select_list.append('apache.mod_proxy')
                select_list.append('apache.mod_proxy_http')
                select_list.append('apache.mod_proxy_fcgi')
                select_list.append('apache.mod_wsgi')
                select_list.append('apache.mod_actions')
                select_list.append('apache.mod_headers')
                select_list.append('apache.mod_pagespeed')
                select_list.append('apache.mod_perl2')
                select_list.append('apache.mod_geoip')
                select_list.append('apache.mod_php5')
                select_list.append('apache.mod_cgi')
                select_list.append('apache.mod_fcgid')
                #select_list.append('apache.mod_fastcgi') not working feb2018
                select_list.append('apache.mod_dav_svn')
                select_list.append('apache.mod_security')
                select_list.append('apache.mod_security.rules')
                select_list.append('apache.mod_socache_shmcb')
                select_list.append('apache.mod_ssl')
                select_list.append('apache.mod_suexec')
                select_list.append('apache.mod_vhost_alias')
                select_list.append('apache.mod_remoteip')
                select_list.append('apache.mod_xsendfile')
                select_list.append('apache.own_default_vhost')
                select_list.append('apache.no_default_vhost')
                select_list.append('apache.vhosts.standard')
                select_list.append('apache.manage_security')
            if item == self.pycharm:
                select_list.append('pycharm')
                select_list.append('pycharm.linuxenv')
                select_list.append('pycharm.developer')
            if item == self.intellij:
                select_list.append('intellij')
                select_list.append('intellij.linuxenv')
                select_list.append('intellij.developer')
            if item == self.eclipse:
                select_list.append('eclipse')
                select_list.append('eclipse.linuxenv')
                select_list.append('eclipse.developer')
                select_list.append('eclipse.plugins')
            if item == self.sqlplus:
                select_list.append('sqlplus')
                select_list.append('sqlplus.linuxenv')
                select_list.append('sqlplus.developer')
            if item == self.sqldeveloper:
                select_list.append('sqldeveloper')
                select_list.append('sqldeveloper.linuxenv')
                select_list.append('sqldeveloper.developer')

        if select_list:
           #Assume users & packages are mandatory
           select_list.insert(0, 'users')
           select_list.insert(0, 'packages')
           try:
               f = open(self.dir + '/top.sls', 'w')
               f.write("base:\n")
               f.write("  '*':\n")
               for ele in select_list:
                   f.write("    - %s\n" % ele)
           finally:
               f.close()
        else:
          print("No selection made.")


#### Run the select screen & handle interrupts
if __name__ == "__main__":
    try:
        outdir = '/srv/salt'
        if len(sys.argv) > 1:
            outdir = str(sys.argv[1])
        App = TestApp(outdir)
        App.run()
    except KeyboardInterrupt:
        print('Interrupted')
        try:
            sys.exit(12)
        except SystemExit:
            os._exit(12)

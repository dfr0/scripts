#!/usr/bin/env python
import subprocess,crypt,random

login = 'username'
password = 'somepassword'

ALPHABET = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
salt = ''.join(random.choice(ALPHABET) for i in range(8))

shadow_password = crypt.crypt(password,'$1$'+salt+'$')

#r = subprocess.call(('usermod', '-p', shadow_password, login))

print shadow_password

#if r != 0:
#    print 'Error changing password for ' + login

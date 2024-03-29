# Weechat setup

```
/script install soju.py
/script install vimode.py
```

Add to `irc.conf`:

```
[server]
sourcehut.addresses = "chat.sr.ht/6697"
sourcehut.proxy
sourcehut.ipv6
sourcehut.tls = on
sourcehut.tls_cert
sourcehut.tls_password
sourcehut.tls_priorities
sourcehut.tls_dhkey_size
sourcehut.tls_fingerprint
sourcehut.tls_verify
sourcehut.password
sourcehut.capabilities
sourcehut.sasl_mechanism
sourcehut.sasl_username = "sourcehut username here"
sourcehut.sasl_password = "sourcehut token here"
sourcehut.sasl_key
sourcehut.sasl_timeout
sourcehut.sasl_fail
sourcehut.autoconnect = on
sourcehut.autoreconnect
sourcehut.autoreconnect_delay
sourcehut.nicks
sourcehut.nicks_alternate
sourcehut.username
sourcehut.realname
sourcehut.local_hostname
sourcehut.usermode
sourcehut.command
sourcehut.command_delay
sourcehut.autojoin
sourcehut.autojoin_dynamic
sourcehut.autorejoin
sourcehut.autorejoin_delay
sourcehut.connection_timeout
sourcehut.anti_flood
sourcehut.away_check
sourcehut.away_check_max_nicks
sourcehut.msg_kick
sourcehut.msg_part
sourcehut.msg_quit
sourcehut.notify
sourcehut.split_msg_max_length
sourcehut.charset_message
sourcehut.default_chantypes
sourcehut.registered_mode
```

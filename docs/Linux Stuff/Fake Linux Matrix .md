# Fake Linux Matrix  
*A fun, useless, and strangely mesmerizing terminal trick*

Sometimes the best scripts aren’t practical at all — they’re just cool.  
This little one‑liner is something I used to run in a terminal window purely for the aesthetic. It reminded me of a low‑budget, chaotic version of the Matrix rain effect… except powered by `/dev/urandom` and pure sysadmin mischief.

It’s not meant for diagnostics, automation, or production use.  
It’s just a fun relic from the era when we all spent too much time in terminals and enjoyed making them look alive.

---

## The Script

```bash
hexdump -C /dev/urandom | GREP_COLOR='1;32' grep --color=auto 'ca fe'
```
<img width="886" height="502" alt="image" src="https://github.com/user-attachments/assets/80ef403f-0390-4d0e-958a-3fd19b50287e" />


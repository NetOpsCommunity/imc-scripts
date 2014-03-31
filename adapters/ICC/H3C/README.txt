IMC seems to have a timing issue when copying the running config via CLI.

The switch responds with "Y/N", but IMC seems to skip that, and go straight to exiting the 
expect loop at "$re_prompt"

Since the switch was waiting for y/n, it would see the next 'n' from the switch, and would 
cancel the copy. Backups would then fail.

Now we basically always send the "y" when exiting the loop.

This was happening maybe 25% of the time. 

Only affected running config, not saved

Re-Based to IMC 7.0 E0202

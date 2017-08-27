#enable OOF for user
Set-MailboxAutoReplyConfiguration user -AutoReplyState Scheduled -EndTime "mm/dd/yyyy hh:mm"
# If you want to change a user's OOF message, you need to export the ExternalMessage or InternalMessage, edit it in your favorite #HTML editor, and import the new message back in.  
$x = Get-MailboxAutoReplyConfiguration user
$x.ExternalMessage | Out-File oof.txt
#edit the HTML in the exported oof.txt file, and then run the following commands to import it:
$oof = Get-Content oof.txt
Set-MailboxAutoReplyConfiguration user -ExternalMessage $oof


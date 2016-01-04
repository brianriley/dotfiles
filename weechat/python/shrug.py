import weechat

weechat.register("shrug", "krinkle", "0.0.1", "Apache-2.0", "Shrug", "", "")

def shrug(data, buffer, args):
    weechat.command(buffer, u"\u00af\_(\u30c4)_/\u00af".encode('utf-8'))
    return weechat.WEECHAT_RC_OK

hook = weechat.hook_command("shrug", "Shrug", "", "", "", "shrug", weechat.current_buffer())

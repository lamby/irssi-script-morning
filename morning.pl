use Irssi;
use POSIX;
use strict;

use vars qw($VERSION %IRSSI);

my $VERSION = "0.1";

%IRSSI = (
	authors => 'Chris Lamb',
	contact => 'chris@chris-lamb.co.uk',
	name => 'morning',
	description => 'Prints a greeting every morning',
	license => 'GPLv3+',
	url => 'https://github.com/lamby/irssi-script-morning',
	changed => ''
);

sub tick {
	POSIX::strftime("%H:%M", localtime) eq
		Irssi::settings_get_str('morning_time') or return;

	my $server = Irssi::server_find_chatnet(
		Irssi::settings_get_str('morning_chatnet')) or return;

	$server->command('msg ' . Irssi::settings_get_str('morning_target')
		. ' ' . Irssi::settings_get_str('morning_msg'));
}

Irssi::settings_add_str($IRSSI{'name'}, 'morning_msg', 'morning');
Irssi::settings_add_str($IRSSI{'name'}, 'morning_time', '08:00');
Irssi::settings_add_str($IRSSI{'name'}, 'morning_chatnet', 'freenode');
Irssi::settings_add_str($IRSSI{'name'}, 'morning_target', '#morning-test');

Irssi::timeout_add(60 * 1000, 'tick', undef);

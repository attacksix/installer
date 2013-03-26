require 'win32/shortcut'
require 'dl'
include Win32

def message_box(txt='', title='', buttons=0)
    user32 = DL.dlopen('user32')
    msgbox = DL::CFunc.new(user32['MessageBoxA'], DL::TYPE_LONG, 'MessageBox')
    r, rs = msgbox.call([0, txt, title, 0].pack('L!ppL!').unpack('L!*'))
    return r
end

chrome_dir=case 
when File.exist?('c:/Program Files/Google/Chrome/Application/chrome.exe')
	'c:/Program Files/Google/Chrome/Application'
when File.exist?('c:/Program Files (x86)/Google/Chrome/Application/chrome.exe')
	'c:/Program Files (x86)/Google/Chrome/Application'
when File.exist?("#{ENV['userprofile']}/AppData/Local/Google/Chrome/Application/chrome.exe")
	"#{ENV['userprofile']}/AppData/Local/Google/Chrome/Application"
else
	message_box("Install Chrome and retry.", "Chrome Not Installed!", "0")
	exit 1
end

case `ver`
	when /5\.1\./
		@shortcuts=["c:/Documents and Settings/All Users/Desktop","c:/Documents and Settings/All Users/Start Menu"]
		@arguments="--disable-popup-blocking --app=https://app.totalcareauto.com"
	when /6\.1\./
		if ENV["username"] == "Administrator"
			@shortcuts=["c:/Users/Public/Desktop","c:/ProgramData/Microsoft/Windows/Start Menu"]
		else
			@shortcuts=["#{ENV['userprofile']}/Desktop","#{ENV['userprofile']}/AppData/Roaming/Microsoft/Windows/Start Menu"]
		end
		@arguments="--app=https://app.totalcareauto.com"
end

@shortcuts.each do |lnk|
	Shortcut.new("#{lnk}/Total Care Auto.lnk") do |s|
	  s.description				=	'Test Shorcut'
	  s.path							=	"#{chrome_dir}/chrome.exe"
	  s.arguments					=	@arguments
	  s.show_cmd					=	Shortcut::SHOWNORMAL
	  s.working_directory	=	chrome_dir
	  s.icon_location			=	'c:/tca/tca_logo.ico'
	end
end

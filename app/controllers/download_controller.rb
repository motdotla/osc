class DownloadController < ApplicationController
  def mac
    redirect_to 'https://github.com/motdotla/oscnode/releases/download/v0.4.0/oscnode-0.4.0.dmg'
  end

  def windows
    redirect_to 'https://github.com/motdotla/oscnode/releases/download/v0.4.0/oscnode-Setup-0.4.0.exe'
  end
end

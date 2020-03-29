module EvClientHelper

  def ev_url(path)
    URI.join(ev_host, path).to_s
  end

  def ev_host
    ENV['EV_URL'] || "#{Settings.ev.protocol}://#{Settings.ev.host}"
  end

end

# http://0.0.0.0:3000/rails/mailers/application

class ApplicationPreview < ActionMailer::Preview
  def developper_notice
    ApplicationMailer.developper_notice(body: ENV.to_h.to_t)
  end
end

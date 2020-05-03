class EvalController < ApplicationController
  def run
    retval = evaluate(current_code)
    console_str = ">> #{current_code}\n#{retval}"

    if v = params[:redirect_to].presence
      redirect_to v
      return
    end

    html = h.content_tag(:pre, console_str)
    render html: html, layout: true
  end

  private

  def current_code
    params[:code]
  end

  def evaluate(input)
    retval = eval(input)
    if !retval.kind_of?(String) && retval.respond_to?(:to_t)
      retval = retval.to_t
    end
    retval
  end
end

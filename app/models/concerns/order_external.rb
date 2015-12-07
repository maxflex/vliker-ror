module OrderExternal extend ActiveSupport::Concern
  require 'net/http'
  require 'uri'
  require 'nokogiri'

  attr_accessor :cookie

  LOGIN_DATA = {
    login: 'maxflex',
    pass: 'fuckyou',
    act: 'login',
  }

  EXTERNAL_SERVICE_URL = 'http://smm-lab.xyz'

  def external_login
    send_request("/", LOGIN_DATA)
  end

  def add_order_to_cart
    response = send_request("/order", {
      object: link,
      act: 'add',
      id: good.good_type.type_id,
      count: good.count,
    })
    self.external_id = parse_external_id(response)
  end

  def update_status
    response = send_request("/myorder")
    parse_status(response)
  end

  def order
    send_request("/order/act/start")
  end

  private
    # parses cart and returns external_id
    def parse_external_id(response)
      page = Nokogiri::HTML(response.body)
      element = page.css("a[href^='http://smm-lab.xyz/order/act/delete/id/']")
      element.last['href'].scan(/\d/).join('')
    end

    def parse_status(response)
      page = Nokogiri::HTML(response.body)
      tr = page.xpath "//tr[td//text()[contains(., '#{external_id}')]]"
      div = tr.css('td > div').last

      # получаем 50/100 (50 – выполнено, 100 – всего)
      data = div['title'].split('/')
      self.external_done = data[0].to_i
      self.external_need = data[1].to_i

      # если заказ завершен
      if external_done >= external_need
        self.done = true
        self.date_done = Time.now
      end
    end

    def set_cookie(response)
      all_cookies = response.get_fields('set-cookie')
      last_cookie = all_cookies.last.split('; ')[0]
    end

    def send_request(url, data = {})
      uri = URI.parse("#{EXTERNAL_SERVICE_URL}#{url}")
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data(data)
      request['Cookie'] = @cookie if @cookie.present?
      response = http.request(request)
      # save cookies
      @cookie ||= set_cookie(response)
      response
    end
end

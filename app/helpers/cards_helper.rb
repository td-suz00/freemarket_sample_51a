module CardsHelper
  def get_card_exp_year
    {'19':'19','20':'20','21':'21','22':'22','23':'23','24':'24','25':'25','26':'26','27':'27','28':'28','29':'29'}
  end

  def get_card_exp(info)
    if info.exp_month < 10
      view_exp_month = "0" + info.exp_month.to_s
    else
      view_exp_month = info.exp_month.to_s
    end
    view_exp_month + " / " + info.exp_year.to_s[2, 2]
  end

  def get_cards_brand_logo(brand)
    case brand
      when 'Visa'
        image_tag 'visa-logo.jpg',size: "47x23" , class: "credit__logo-img"
      when 'JCB'
        image_tag 'jcb-logo.svg',size: "34x23" , class: "credit__logo-img"
      when 'MasterCard'
        image_tag 'mastercard-logo.svg',size: "27x23" , class: "credit__logo-img"
      when 'American Express'
        image_tag 'amex-logo.gif',size: "23x23" , class: "credit__logo-img"
      when 'Diners Club'
        image_tag 'diners-logo.gif',size: "27x23" , class: "credit__logo-img"
      when 'Discover'
        image_tag 'discover-logo.gif',size: "27x23" , class: "credit__logo-img"
    end
  end
end

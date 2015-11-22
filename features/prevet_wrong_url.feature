Feature: Prevent VLiker from wrong URLs

  As a VLiker newcomer
  I paste-in the wrong unformatted url
  And get the corresponding error message

  @javascript
  Scenario Outline: submit example url
    Given the url is "<url>"
    When I submit the url
    Then the error message should be
      """
        Это пример. Введите адрес своей страницы, куда хотите накрутить сердечки
      """

    Scenarios: example urls
      | url                           |
      | http://vk.com/photo236886_332 |
      | http://vk.com/wall123123552   |

  @javascript
  Scenario Outline: sumbit wrong url
    Given the url is "<url>"
    When I submit the url
    Then the error message should be
      """
        Неверный адрес. Ссылка должна начинаться с http://vk.com/
      """

    Scenarios: wrong urls
      | url                 |
      | http://google.com   |
      | https://youtube.com |
      | http://kolyadin.com |

  @javascript
  Scenario: blank url
    Given the url is ""
    When I submit the url
    Then the error message should be
      """
        Введите адрес страницы, куда хотите накрутить сердечки!
      """
  @javascript
  Scenario: url not specified
    Given the url is "http://vk.com/maxflex"
    When I submit the url
    Then the error message should be
      """
        Укажите точный адрес фотографии, видео, записи или комментария
      """

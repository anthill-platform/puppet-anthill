#
# Anthill Commons library
#
# @option editor icon data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAYdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjEuMWMqnEsAAALdSURBVFhHvZdbTxNBFMf7aPwW+qApUNu6XSjd0tILYIQIEUMTjJ9AxQjGiNFANDwTY4zRR0N41ahAfBA1ilLEFi8JEPVBgoIpwUqaYE3acc/s7LK7Pd1LQ/0nv3TmP2d7zu7MXsYhyxeMxXkhRuq8DeRAjUfEvas4D3HEF4gSXoguspQ7EhMvOV0cemA1gBNlqaUz/5/JZZQioIEFVBuYalqANOd4UDlCkdYSr87Dl3hmcEJkzIENGJHJZHB/YwP1jeCFSN5WAQdrPSTYHFf6t27f0Zz56b7zStsKdB1gA0YMXRsh6+s/iVr3HzwkHz5+QuONqKgA4ExfP0st6dvKChonU+v2ob5hAZ+/fEV9IJ/Ps9Q7wuKA1dXvqA+YXoGl5WXUx4TFXb46jPoylqYA5PM3abzfW1ukWCzSMVnqcQDk5QMlvhrLa2By6gm9zZwur+KpdSJxUvFfvpoxnD41thchCM78x9oabcsqFApk/l2KtuFWxY7FsF0AUCO+1TAFQvYf6ZYK6O7pJcm5eZokl8uJD5+7JJvN0r5a/Rcukc3NX7QNv9DH/k9N2QL8wWbSebyH8I0h4vE1asbOnhugSdSCKRi+PqKJc3nr6eJN9J4qe3UqmgKgqzvBUku6NzaOxplRUQFcg0BmXs+y1JLezCZJvK0DjTfCdgHb239YyvLCjiuHrQJAR9q7iJvz07Zeg1eGlDsErhL2H3osFwCS25AIU3rhvRID3wz6xYthqYDk3FtNv/XoMZZSq6fTzzRxAxcH6Z2g9vSYFvBoYhL1MbW1d5bEwWNZ76kxLSCVXkB9q6/j0Rs3UV/GtIDp5y9QH4CHjyxsHIBPNsyXoQXAjgUbBB5PTKG+VfTrQg8nRNMO2C5hg9UG3pripmi/uDGJLmIB1YZeflnQwYKqxWF/mHBcx16WXhIUUckuyQ5w2SFPOBzew9KWig/ExsWgvxC4u0RS9U0t+1gaJofjH0XsHcGE7LRRAAAAAElFTkSuQmCC
#
class anthill::common (
  String $repository_remote_url                       = $anthill::common::params::repository_remote_url,
  String $packge_name                                 = $anthill::common::params::package_name,
  Optional[String] $private_ssh_key                   = undef
) inherits anthill::common::params {

  anthill::index::repo { $repository_remote_url:
    private_ssh_key => $private_ssh_key
  }

}
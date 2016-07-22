# Class: puppet_masterless
# ===========================
#
# Manageds puppet_masterless config
#
class puppet_masterless {

  case $kernel {
    'Linux': {
      include puppet_masterless::linux
    }
    'windows': {
      include puppet_masterless::windows
    }
    default: {
      fail("${kernel} not supported")
    }
  }

}

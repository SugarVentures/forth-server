module AppException
  class AuthenticationError < StandardError
  end

  class InvalidFabricToken < StandardError
  end

  class EmailUnconfirmed < StandardError
  end
end

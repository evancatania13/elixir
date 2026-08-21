defmodule Secrets do
  def secret_add(secret) do
    # Please implement the secret_add/1 function
    secret_add = fn param ->
      secret + param
    end
  end

  def secret_subtract(secret) do
    # Please implement the secret_subtract/1 function
    secret_subtract = fn param ->
      param - secret
    end
  end

  def secret_multiply(secret) do
    # Please implement the secret_multiply/1 function
    secret_multiply = fn param -> 
      param * secret
    end
  end

  def secret_divide(secret) do
    # Please implement the secret_divide/1 function
    secret_divide = fn param ->
      div(param, secret)
    end
  end

  def secret_and(secret) do
    # Please implement the secret_and/1 function
    secret_and = fn param ->
      Bitwise.band(secret,param)
    end
  end

  def secret_xor(secret) do
    # Please implement the secret_xor/1 function
    secret_xor = fn param ->
      Bitwise.bxor(param,secret)
    end
  end

  def secret_combine(secret_function1, secret_function2) do
    # Please implement the secret_combine/2 function
    secret_combine = fn param -> 
      secret_function2.(secret_function1.(param))
    end
  end
end

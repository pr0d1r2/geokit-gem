class GeokitCachedGenerator < RspecModelGenerator

  def initialize(runtime_args, runtime_options = {})
    runtime_args = ['CachedLocation', 'address:string', 'provider:string', 'lng:float', 'lat:float', 'city:string']
    super
  end

end
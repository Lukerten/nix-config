{
  # describes a general use for a system
  archetype = import ./archetype;

  # Describes a specific use for a system
  suits = import ./suits;

  # Describes the system itself
  programs = import ./programs;
  services = import ./services;
  system = import ./system;
  qt = import ./qt;
}

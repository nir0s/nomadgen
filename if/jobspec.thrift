struct Constraint {
  1: optional string LTarget
  2: optional string RTarget
  3: optional string Operand
}

typedef map<string,string> Meta
struct ParamaterizedJob {}
struct Update {
  1: optional i64 MaxParallel
  2: optional i64 Stagger
  3: optional string HealthCheck
  4: optional i64 MinHealthyTime
  5: optional i64 HealthyDeadline
  6: optional bool AutoRevert
  7: optional i64 Canary
}
struct Periodic {
  1: optional bool Enabled
  2: optional string SpecType
  3: optional string Spec
  4: optional bool ProhibitOverlap
}
struct RestartPolicy {
  1: optional i64 Attempts
  2: optional i64 Interval
  3: optional i64 Delay
  4: optional string Mode
}
struct Artifact {
  1: required string GetterSource
  2: optional string RetrivalDest
  3: optional map<string,string> GetterOptions
}
struct LogConfig {
  1: required i32 MaxFiles = 3
  2: required i32 MaxFileSizeMB = 10
}
struct Port {
  1: required string Label
  2: optional i32 Value
}
struct Network {
  1: optional i64 MBits
  2: optional list<Port> DynamicPorts
  3: optional list<Port> ReservedPorts
}
struct Resources {
  1: optional i64 CPU
  2: optional i64 DiskMB
  3: optional i16 IOPS
  4: optional i64 MemoryMB
  5: optional list<Network> Networks
}
struct Check {
  1: required string Type
  2: required string Name
  3: required i64 Interval
  4: required i64 Timeout
  5: optional string Path
  6: optional string Protocol
  7: optional string Command
  8: optional list<string> Args
}
struct Service {
  1: required string Name
  2: optional list<string> Tags
  3: optional string PortLabel
  4: optional list<Check> Checks
}
struct Template {
  1: optional string SourcePath
  2: optional string EmbeddedTmpl
  3: required string DestPath
  4: optional string ChangeMode
  5: optional string ChangeSignal
  6: optional i64 Splay
}
struct Config {
  1: optional string image
  2: optional string command
  3: optional list<map<string,string>> port_map
  4: optional list<string> command_args
  5: optional string image_path
  6: optional string accelerator
  7: optional list<string> volumes
  8: optional list<string> dns_search_domains
  9: optional list<string> dns_servers
  10: optional list<string> extra_hosts
  11: optional string hostname
  12: optional bool interactive
  13: optional string ipc_mode
  14: optional string ipv4_address
  15: optional string ipv6_address
  16: optional map<string,string> labels
  17: optional list<string> load
  // TODO: Add logging
  18: optional string mac_address
  19: optional list<string> network_aliases
  20: optional string network_mode
  21: optional string pid_mode
  22: optional bool privileged
  23: optional list<string> security_opt
  24: optional i64 shm_size
  25: optional bool tty
  26: optional string uts_mode
  27: optional string userns_mode
  28: optional string volume_driver
  29: optional string work_dir
}
struct Vault {
  1: required list<string> Policies
  2: optional bool Env = 1
  3: optional string ChangeMode = "noop"
  4: optional string ChangeSignal
}
struct Task {
  1: optional list<Artifact> Artifacts
  2: optional Config Config
  3: optional list<Constraint> Constraints
  4: optional string DispatchPayload
  5: required string Driver
  6: optional map<string,string> Env
  7: optional i64 KillTimeout
  8: optional LogConfig LogConfig
  9: optional Meta Meta
  10: required string Name
  11: required Resources Resources
  12: optional list<Service> Services
  13: optional list<Template> Templates
  14: optional string User
  15: optional Vault Vault
}
struct EphemeralDisk {
  1: required i32 SizeMB
  2: optional bool Sticky = 0
  3: optional bool Migrate = 0
}
struct TaskGroup {
  1: optional list<Constraint> Constraints
  2: optional i64 Count
  3: optional Meta Meta
  4: required string Name
  5: optional RestartPolicy RestartPolicy
  6: optional list<Task> Tasks
  7: optional EphemeralDisk EphemeralDisk
}
struct Job {
  1: optional bool AllAtOnce
  2: optional list<Constraint> Constraints
  3: optional list<string> Datacenters
  4: optional list<TaskGroup> TaskGroups
  5: optional Meta Meta
  6: optional ParamaterizedJob ParamaterizedJob
  7: optional string Payload
  8: optional i16 Priority = 50
  9: optional string Region
  10: optional string Type
  11: optional Update Update
  12: optional Periodic Periodic
  13: required string Name
  14: required string ID
}

struct NomadJob {
  1: Job Job
  2: optional bool Diff
}

const i64 SECOND = 1000000000

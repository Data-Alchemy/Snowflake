### Roles 

#### Overview
Snowflake uses roles to grant permissions to objects in its ecosystem. This script creates a role hierarchy that also introduces 
role groups to grant access to different areas more effectively in the Snowflake org. Here is the breakdown of the groups 

| Group Name  | Description |
| ------------- | ------------- |
| ROOT Group | Gives full admin priveledges across all schemas in database  |
| RWX Group  | Gives read write and exe priveledges across all schemas in database  |
| RX Group   | Gives read exe priveledges across all schemas in database  |



select
    row_number() over() as tag_id,
    tag_name
from {{ ref('so_file') }}

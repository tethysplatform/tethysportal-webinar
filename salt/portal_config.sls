{% set TETHYS_PERSIST = salt['environ.get']('TETHYS_PERSIST') %}
{% set STATIC_ROOT = salt['environ.get']('STATIC_ROOT') %}

Move_Custom_Theme_Files_to_Static_Root:
  cmd.run:
    - name: mv /images/portal-icon.png {{ STATIC_ROOT }}/tethys_portal
    - shell: /bin/bash
    - unless: /bin/bash -c "[ -f "{{ TETHYS_PERSIST }}/custom_theme_setup_complete" ];"

Apply_Custom_Theme:
  cmd.run:
    - name: >
        tethys site
        --site-title "Deployed Portal"
        --brand-text "My First Deployed Portal"
        --apps-library-title "Applications"
        --primary-color "#01200F"
        --secondary-color "#358600"
        --background-color "#ffffff"
        --brand-image "/tethys_portal/portal-icon.png"
        --copyright "Copyright © 2023 My Organization"
    - shell: /bin/bash
    - unless: /bin/bash -c "[ -f "{{ TETHYS_PERSIST }}/custom_theme_setup_complete" ];"

Flag_Custom_Theme_Setup_Complete:
  cmd.run:
    - name: touch {{ TETHYS_PERSIST }}/custom_theme_setup_complete
    - shell: /bin/bash
    - unless: /bin/bash -c "[ -f "{{ TETHYS_PERSIST }}/custom_theme_setup_complete" ];"
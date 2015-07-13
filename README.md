
williamyeh.elasticsearch for Ansible Galaxy
============

[![Circle CI](https://circleci.com/gh/William-Yeh/ansible-elasticsearch.svg?style=shield)](https://circleci.com/gh/William-Yeh/ansible-elasticsearch)




## Summary

Role name in Ansible Galaxy: **[williamyeh.elasticsearch](https://galaxy.ansible.com/list#/roles/2859)**

This Ansible role has the following features for [Elasticsearch](http://www.elasticsearch.org/):

 - Install Elasticsearch.
 - Specify heap size and G1GC for JVM, if requested.
 - Install plugins.
 - Bare bone configuration (*real* configuration should be left to user's template files; see **Usage** section below).



## Role Variables

### Mandatory variables

Variables needed to be defined in user's playbook:

```yaml
elasticsearch_version
```


### Optional variables


User-installable configuration files (by Ansible's template system):

```yaml
# conf file (usually elasticsearch.yml) to be installed,
# relative to `playbook_dir`;
# the file will be copied verbatim
elasticsearch_conf_copy

# conf file (usually elasticsearch.yml.j2) to be installed,
# relative to `playbook_dir`;
# the file will be copied through Ansible's template system
elasticsearch_conf_template
```

User-installable plugins:

```yaml
# an array of plugins (registered in elasticsearch.org) to be installed
# @see http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/modules-plugins.html
elasticsearch_plugins

# an array of other plugins to be installed
elasticsearch_other_plugins
```


User-configurable defaults:

```yaml
# use G1GC for JVM?
elasticsearch_use_g1gc: false


# JVM heap size for Elasticsearch
elasticsearch_heap_size
```




## Handlers

- `restart elasticsearch`

- `stop elasticsearch`




## Usage


### Step 1: add role

Add role name `williamyeh.elasticsearch` to your playbook file.


### Step 2: add variables

Set vars in your playbook file.

Simple example:

```yaml
---
# file: simple-playbook.yml

- hosts: all

  roles:
    - williamyeh.oracle-java
    - williamyeh.elasticsearch

  vars:
    elasticsearch_version: 1.6.0
```


### Step 3: tune JVM memory, if necessary


```yaml
---
- hosts: all

  roles:
    - williamyeh.oracle-java
    - williamyeh.elasticsearch

  vars:
    elasticsearch_version: 1.4.2

    elasticsearch_use_g1gc: true
    elasticsearch_heap_size: 6g

```


### Step 4: copy user's config file, install plugins, etc., if necessary

More practical example:

```yaml
---
# file: complex-playbook.yml

- hosts: all

  roles:
    - williamyeh.oracle-java
    - williamyeh.elasticsearch

  vars:
    elasticsearch_version: 1.4.2

    elasticsearch_plugins:
      - lmenezes/elasticsearch-kopf

    elasticsearch_other_plugins:
      - name: analysis-ik
        url:  https://github.com/medcl/elasticsearch-rtf/raw/master/plugins/analysis-ik/elasticsearch-analysis-ik-1.2.6.jar
        memo: https://github.com/medcl/elasticsearch-analysis-ik

    #-- copy verbatim
    elasticsearch_conf_copy: "files/elasticsearch.yml"

    #-- copy through Ansible's template system
    #elasticsearch_conf_template: "templates/elasticsearch.yml.j2"
```



## Dependencies

Your target hosts should have JDK pre-installed.  You may use [williamyeh.oracle-java](https://galaxy.ansible.com/list#/roles/2851) or other roles existed in Ansible Galaxy.


## License

Licensed under the Apache License V2.0. See the [LICENSE file](LICENSE) for details.


## History

None.

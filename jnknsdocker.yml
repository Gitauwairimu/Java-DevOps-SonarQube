---
- name: Install Docker docker build and push
  hosts: deb
  ignore_unreachable: yes
  gather_facts: no

  tasks:
  - name: Add Docker GPG apt Key
    apt_key:
      url: https://download.docker.com/linux/ubuntu/gpg
      state: present

  - name: Add Docker Repository
    apt_repository:
      repo: deb https://download.docker.com/linux/ubuntu bionic stable
      state: present
    become: true

  - name: Update apt and install docker-ce
    apt: update_cache=yes name=docker-ce state=latest
    become: true

---
- name: Docker build and push
  hosts: deb
  ignore_unreachable: yes
  gather_facts: no

  vars:
    source: '/var/jenkins_home/workspace/fasto/target/demo-0.0.1-SNAPSHOT.jar' 
    destination: '/home/vagrant/java_project'

  tasks:
  - name: copy Git files
    ansible.builtin.copy:
      src: "{{ item }}"
      dest: '{{ destination }}'
      owner: vagrant
      mode: '0644'
    with_fileglob:
      - "Dockerfile"


  - name: Copy jar file by synchronization 
    ansible.posix.synchronize:
      src: '{{ source }}'
      dest: '{{ destination }}'
    become: true  

  - name: build container image
    docker_image:
      name: appcontainer:v1.0
      build:
        path: /home/vagrant/java_project/Dockerfile
        source: build
      state: present

  - name: Log into DockerHub
    docker_login:
      username: ${DOCKERHUB_USERNAME}
      password: ${DOCKERHUB_PASSWORD}

  - name: Tag and push to docker hub
    docker_image:
      name: appcontainer:v1.0
      repository: gitauwairimu/app:7.56
      push: yes
      source: local



# ssh into docker server
# execute a playbook that- 

# installs docker, 
# copies .tar file to the server, 
# builds an image, 
# push to dockerhub
# deploys it and 
# gives server/service status

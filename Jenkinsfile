pipeline {
  agent any
  parameters {
    choice(
        name: 'Action',
        choices: "apply\ndestroy",
        description: 'Apply or Destroy the instance' )
  }
  stages {

    stage('Checkout') {
        steps {
            git branch: 'main', credentialsId: 'jenkins-github', url: 'git@github.com:ddoyencourt/nginx-jenkins-ansible-terraform.git'
        }
    }

    stage('Terraform') {
      steps {
        script {
          if (params.Action == "apply") {
            sh 'terraform -chdir=terraform/static-site init'
            sh 'terraform -chdir=terraform/static-site apply -var "name=hello" -var "group=web" -var "region=us-east-1" -var "profile=dim" --auto-approve'
          } 
          else {
            sh 'terraform -chdir=terraform/static-site destroy -var "name=hello" -var "group=web" -var "region=us-east-1" -var "profile=dim" --auto-approve'
          }
        }
      }
    }

    stage('Ansible') {
      steps {
        retry(count: 5) {
          sh 'ansible-playbook -i /etc/ansible/aws_ec2.yaml ansible/static-site/site.yaml'
        }
      }
    }
  }
}

pipeline {
    agent any

	tools {
		maven 'maven3.6'
	}

    stages {
		stage('Clone-Repo') {
			steps {
				checkout scm
			}
		}
	
		stage('Build') {
			steps {
				sh 'mvn install'
			}
		}
		
		stage('Unit Tests') {
			steps {
				sh 'mvn compiler:testCompile'
				sh 'mvn surefire:test'
			}
		}

	
		stage('Deployment') {
			steps {
				sh 'sudo docker build -t demouser/demo-img -f Dockerfile .'
				sh 'docker rm -f ${docker ps -q}'
                                sh './create-env.sh 10'
	    	}
		}
    }
}

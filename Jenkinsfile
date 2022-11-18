pipeline {
    agent any

	tools {
		maven 'maven'
	}

        environment {

                NEXUS_VERSION = "NEXUS3"

               NEXUS_PROTOCOL = "http"
               NEXUS_URL = "127.0.1.1:8081"
               NEXUS_REPOSITORY = "SAMPLE_SNP"
              // NEXUS_CREDENTIAL_ID = "nexus_credentials"
               
                
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
		
                stage('publish to nexus') {

                steps {

                      script {
                      
                      pom = readMavenPom file : "pom.xml";
                      filesByGlob = findFiles(glob: "target/*.${pom.packaging}");
                      artifactPath = filesByGlob[0].path;
                      artifactExists = fileExists artifactPath;
                      if(artifactExists) {

                       nexusArtifactUploader(

                       nexusVersion: NEXUS_VERSION,
                       protocol: NEXUS_PROTOCOL,
                       nexusUrl: NEXUS_URL,
                       groupId: pom.groupId,
                       version: '${BUILD_NUMBER}',
                       repository: NEXUS_REPOSITORY,
                       //credentialsId: NEXUS_CREDENTIAL_ID,
                       artifacts: [

                       [artifactId: pom.artifactId,
                        classifier: '',
                        file: artifactPath,
                        type: pom.packaging],
                        [artifactId: pom.artifactId,
                         classifier: '',
                         file: "pom.xml",
                         type:   "pom"]
                        
                        ]                       
                      
                       );
                         
                          }

               }
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
				sh 'docker build -t demouser/demo-img -f Dockerfile .'
			//	sh 'docker rm -f ${docker ps -q}'
                                sh './create-env.sh 3'
	    	}
		}
    }
}

def zones = [
    [ cluster_name: '1', metall_lb_ip: '2', storage_class: '3' ],
    [ cluster_name: '4', metall_lb_ip: '5', storage_class: '6' ],
    [ cluster_name: '7', metall_lb_ip: '8', storage_class: '9' ],
    [ cluster_name: '10', metall_lb_ip: '11', storage_class: '12' ],
    [ cluster_name: '13', metall_lb_ip: '14', storage_class: '15' ],
]

def runs = [:]

pipeline {
    agent { node { label 'test' } }

    environment {
        NAMESPACE = 'kpi'
        DEPLOY_IMAGE = 'IMAGE'
    }

    stages {
        stage('Prepear stages') {
            steps {
                script {
                    zones.eachWithIndex { v, i ->
                        runs[i] = deploy(v)
                    }
                    parallel runs
                }
            }
        }
    }

    post {
        always {
            sh "rm -rf ./* ./.git"
        }
    }
}

def deploy(Map m) {
    return {
        try{
            stage ('Deploy ' + m.cluster_name) {
                withCredentials([file(credentialsId: "${m.cluster_name}", variable: 'FILE' )]) {
                    sh 'cp $FILE $PWD'
                }

                sh "docker run -i --rm -u 11160:11160 -v ${WORKSPACE}:${WORKSPACE} -w ${WORKSPACE} ${DEPLOY_IMAGE} \
                    helm upgrade ${NAMESPACE}-rabbitmq ../jenkinsfile \
                    --install \
                    --history-max 5 \
                    --namespace ${NAMESPACE} \
                    --timeout 5m0s \
                    --kubeconfig=${WORKSPACE}/${m.cluster_name} \
                    --set clusterName=${m.cluster_name} \
                    --set lbIp=${m.metall_lb_ip} \
                    --set storageClassName=${m.storage_class}"

                sh "curl --max-time 70 \
                    -H 'Authorization: Basic TOKEN' \
                    -H 'content-type: application/json' \
                    -X POST --data @config.json \
                    http://${m.metall_lb_ip}:15672/api/definitions"
            }
        } catch(e) {
            echo e.toString()
        }
    }
}


#/usr/bin/env sh
#   Written by Peter L. Morrell and Corey Carter
#   07 August 2019, Falcon Heights, MN

set -euf - o pipefail

configOrArgument(){
    # args=($@)
    if (( $# == 2 )) && [[ ${$@[0]} == "-c" ]] && [[ -f ${@[1]} ]]; then
        #   The configuation file contains the input file path sample name
        source Config
    else
        argumentLoader
    fi

}

argumentLoader(){
    local args=($@)
    local indexVar=0
    for argument in ${args[@]}; do
        if [[ "${argument}" == "-o" ]]; then
            local var=${args[indexVar + 1]}
            output="${var}"
        elif [[ "${argument}" == "-f5" ]]; then
            local var=${args[indexVar + 1]}
            fast5="${var}"
        elif [[ "${argument}" == "-fc" ]]; then
            local var=${args[indexVar + 1]}
            flowCell="${var}"
        elif [[ "${argument}" == "-k" ]]; then
            local var=${args[indexVar + 1]}
            kit="${var}"
        elif [[ "${argument}" == "-sn" ]]; then
            local var=${args[indexVar + 1]}
            sampleName="${var}"
        fi
        ((indexVar+=1))
    done


}

argChecker(){
    variables=(guppyLocation fast5 output flowCell kit sampleName)
    for element in ${variables[@]}; do
        if [[ "${element}" == "${output}" ]]; then

        elif [[ "${element}" == "${fast5}" ]]; then

        elif [[ "${element}" == "${flowCell}" ]]; then

        elif [[ "${element}" == "${kit}" ]]; then

        elif [[ "${element}" == "${sampleName}"  ]]; then

        fi
    done


}

main(){

    configOrArgument
    argChecker

    # guppyLocation=/Applications/ont-guppy-cpu/bin/guppy_basecaller

    finalOutput="${output}/${sampleName}"

    mkdir -p "${finalOutput}"/basecalled

    $guppyLocation --recursive --input_path "${fast5}" --save_path $output --flowcell "${flowCell}" --kit "${kit}"

}

main $@
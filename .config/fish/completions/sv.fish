# completion for sv

function __fish_sv_has_subcommand --description 'Return 0 if sv has been given a subcommand'
    for i in (commandline -opc)
        if contains -- $i u up d down o once p pause c cont h hup a alarm i interrupt q quit 1 2 t term k kill e exit s status start stop reload restart shutdown force-stop force-reload force-restart force-shutdown try-restart check
            return 0
        end
    end
    return 1
end

function __fish_sv_no_subcommand --description 'Return 0 if sv has not been given a subcommand'
    for i in (commandline -opc)
        if contains -- $i u up d down o once p pause c cont h hup a alarm i interrupt q quit 1 2 t term k kill e exit s status start stop reload restart shutdown force-stop force-reload force-restart force-shutdown try-restart check
            return 1
        end
    end
    return 0
end

# Service args
complete -x -c sv -n '__fish_sv_has_subcommand' -a "(/bin/ls /var/service/)" -d 'Service'
# Commands
complete -c sv -a 's status' -d 'Report the current status of the service, and the appendant log service if available, to standard output.' -n '__fish_sv_no_subcommand' -x
complete -c sv -a 'u up' -d 'If the service is not running, start it.  If the service stops, restart it.' -n '__fish_sv_no_subcommand' -x
complete -c sv -a 'd down' -d 'If the service is running, send it the TERM signal, and the CONT signal.  If ./run exits, start ./finish if it exists.  After it stops, do not restart service.' -n '__fish_sv_no_subcommand' -x
complete -c sv -a 'o once' -d 'If the service is not running, start it.  Do not restart it if it stops.' -n '__fish_sv_no_subcommand' -x
complete -c sv -a 'p pause c cont h hup a alarm i interrupt q quit 1 2 t term k kill' -d 'If the service is running, send it the STOP, CONT, HUP, ALRM, INT, QUIT, USR1, USR2, TERM, or KILL signal respectively.' -n '__fish_sv_no_subcommand' -x
complete -c sv -a 'e exit' -d 'If the service is running, send it the TERM signal, and the CONT signal.  Do not restart the service.  If the service is down, and no log service exists, runsv(8) exits.  If the service is down and a log service exists, runsv(8) closes the standard input of the log service and waits for it to terminate.  If the log service is down, runsv(8) exits.  This command is ignored if it is given to an appendant log service.' -n '__fish_sv_no_subcommand' -x
complete -c sv -a 'start' -d 'Same as up, but wait up to 7 seconds for the command to take effect.  Then report the status or timeout.  If the script ./check exists in the service directory, sv runs this script to check whether the service is up and available; it\'s considered to be available if ./check exits with 0.' -n '__fish_sv_no_subcommand' -x
complete -c sv -a 'stop' -d 'Same as down, but wait up to 7 seconds for the service to become down.  Then report the status or timeout.' -n '__fish_sv_no_subcommand' -x
complete -c sv -a 'reload' -d 'Same as hup, and additionally report the status afterwards.' -n '__fish_sv_no_subcommand' -x
complete -c sv -a 'restart' -d 'Send the commands term, cont, and up to the service, and wait up to 7 seconds for the service to restart.  Then report the status or timeout.  If the script ./check exists in the service directory, sv runs this script to check whether the service is up and available again; it\'s considered to be available if ./check exits with 0.' -n '__fish_sv_no_subcommand' -x
complete -c sv -a 'shutdown' -d 'Same as exit, but wait up to 7 seconds for the runsv(8) process to terminate.  Then report the status or timeout.' -n '__fish_sv_no_subcommand' -x
complete -c sv -a 'force-stop' -d 'Same as down, but wait up to 7 seconds for the service to become down.  Then report the status, and on timeout send the service the kill command.' -n '__fish_sv_no_subcommand' -x
complete -c sv -a 'force-reload' -d 'Send the service the term and cont commands, and wait up to 7 seconds for the service to restart.  Then report the status, and on timeout send the service the kill command.' -n '__fish_sv_no_subcommand' -x
complete -c sv -a 'force-restart' -d 'Send the service the term, cont and up commands, and wait up to 7 seconds for the service to restart.  Then report the status, and on timeout send the service the kill command.  If the script ./check exists in the service directory, sv runs this script to check whether the service is up and available again; it\'s considered to be available if ./check exits with 0.' -n '__fish_sv_no_subcommand' -x
complete -c sv -a 'force-shutdown' -d 'Same as exit, but wait up to 7 seconds for the runsv(8) process to terminate.  Then report the status, and on timeout send the service the kill command.' -n '__fish_sv_no_subcommand' -x
complete -c sv -a 'try-restart' -d 'if the service is running, send it the term and cont commands, and wait up to 7 seconds for the service to restart.  Then report the status or timeout.' -n '__fish_sv_no_subcommand' -x
complete -c sv -a 'check' -d 'Check for the service to be in the state that\'s been requested.  Wait up to 7 seconds for the service to reach the requested state, then report the status or timeout.  If the requested state of the service is up, and the script ./check exists in the service directory, sv runs this script to check whether the service is up and running; it\'s considered to be up if ./check exits with 0.' -n '__fish_sv_no_subcommand' -x
# Options
complete -c sv -s v -d 'If the command is up, down, term, once, cont, or exit, then wait up to 7 seconds for the command to take effect.  Then report the status or timeout.' -f
complete -c sv -s w -d 'Override the default timeout of 7 seconds with sec seconds.  This option implies -v.' -r

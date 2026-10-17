# Increase power limit

These scripts can increase the CPU powerlimit on Linux for laptops (specifically tested on EliteBook 850 G7 using i7-10610U) going from 15W to 25W.

The commands needed:

      sudo su
      echo 25000000 > /sys/class/powercap/intel-rapl-mmio:0/constraint_0_power_limit_uw
      echo 25000000 > /sys/class/powercap/intel-rapl:0/constraint_0_power_limit_uw
      echo 25000000 > /sys/class/powercap/int^C-rapl-mmio:0/constraint_1_power_limit_uw

## Making it permanent

Copy the files:

    sudo su
    cp cpu-power-limit /usr/lib/systemd/system-sleep/cpu-power-limit
    chmod +x /usr/lib/systemd/system-sleep/cpu-power-limit

    cp cpu-power-limit.service /etc/systemd/system/cpu-power-limit.service
    systemctl daemon-reload
    systemctl enable --now cpu-power-limit.service

## Debug

There may be other power limits, run this script to explore all power limits

    for d in /sys/class/powercap/intel-rapl*; do
        [ -d "$d" ] || continue
        echo "=== $d ==="
        for f in "$d"/constraint_*_power_limit_uw; do
            [ -f "$f" ] && echo "$f: $(cat "$f")"
        done
    done

To see the actual amount of power used, use:

    sudo intel_gpu_top

Make sure to monitor the temperatures too, CPU might be thermally throttled

    sensors

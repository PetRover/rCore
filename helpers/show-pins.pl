#!/usr/bin/perl

use v5.14;
use strict;
use warnings qw( FATAL all );
use autodie;
use utf8;

binmode STDOUT, ':utf8';

my $verbose = 0;

while( @ARGV && $ARGV[0] =~ s/^-v/-/ ) {
	++$verbose;
	shift if $ARGV[0] eq '-';
}
die "unexpected argument: $ARGV[0]\n"  if @ARGV;

my @data = map { chomp; [ split /\t+/ ] } grep /^[^#]/, <DATA>;

@ARGV = '/sys/kernel/debug/pinctrl/44e10800.pinmux/pins';

while( <> ) {
	s/\s*\z//;
	/^pin / or next;

	/^pin (\d+) \(44e1([0-9a-f]{4})\.0\) 000000([0-7][0-9a-f]) pinctrl-single\z/ or die "parse error";
	my $pin = $1;
	my $reg = hex $2;
	my $mux = hex $3;
	0x800 + 4 * $pin == $reg  or die "sanity check failed";

	my $label = $data[ $pin ][ 8 ] // next;
        next if $label =~ s/^-// && $verbose < 2;
        next unless $verbose || $label =~ /^P[89]\./;

	my $slew = ( "fast", "slow" )[ $mux >> 6 & 1 ];
	my $rx = ( "", "rx" )[ $mux >> 5 & 1 ];
	my $pull = ( "down", "up" )[ $mux >> 4 & 1 ];
	$pull = "" if $mux >> 3 & 1;
	$mux &= 7;

	my $function = $data[ $pin ][ $mux ];
	$function = '*** INVALID ***'  if $function eq '-';

	printf "%-32s %3d  %-4s  %-2s  %-4s  [%1d] %s\n",
		$label, $pin, $slew, $rx, $pull, $mux, $function;
}

__DATA__
gpmc d0			mmc 1 d0		-			-			-			-			-			gpio 1.00		P8.25 / eMMC d0
gpmc d1			mmc 1 d1		-			-			-			-			-			gpio 1.01		P8.24 / eMMC d1
gpmc d2			mmc 1 d2		-			-			-			-			-			gpio 1.02		P8.05 / eMMC d2
gpmc d3			mmc 1 d3		-			-			-			-			-			gpio 1.03		P8.06 / eMMC d3
gpmc d4			mmc 1 d4		-			-			-			-			-			gpio 1.04		P8.23 / eMMC d4
gpmc d5			mmc 1 d5		-			-			-			-			-			gpio 1.05		P8.22 / eMMC d5
gpmc d6			mmc 1 d6		-			-			-			-			-			gpio 1.06		P8.03 / eMMC d6
gpmc d7			mmc 1 d7		-			-			-			-			-			gpio 1.07		P8.04 / eMMC d7
gpmc d8			lcd d23			mmc 1 d0		mmc 2 d4		pwm 2 out A		pru mii 0 txclk		-			gpio 0.22		P8.19
gpmc d9			lcd d22			mmc 1 d1		mmc 2 d5		pwm 2 out B		pru mii 0 col		-			gpio 0.23		P8.13
gpmc d10		lcd d21			mmc 1 d2		mmc 2 d6		pwm 2 tripzone		pru mii 0 txen		-			gpio 0.26		P8.14
gpmc d11		lcd d20			mmc 1 d3		mmc 2 d7		pwm sync out		pru mii 0 txd3		-			gpio 0.27		P8.17
gpmc d12		lcd d19			mmc 1 d4		mmc 2 d0		qep 2 in A		pru mii 0 txd2		pru 0 out 14		gpio 1.12		P8.12
gpmc d13		lcd d18			mmc 1 d5		mmc 2 d1		qep 2 in B		pru mii 0 txd1		pru 0 out 15		gpio 1.13		P8.11
gpmc d14		lcd d17			mmc 1 d6		mmc 2 d2		qep 2 index		pru mii 0 txd0		pru 0 in 14		gpio 1.14		P8.16
gpmc d15		lcd d16			mmc 1 d7		mmc 2 d3		qep 2 strobe		pru eCAP		pru 0 in 15		gpio 1.15		P8.15
gpmc a0			mii 1 txen		rgmii 1 txctl		rmii 1 txen		gpmc a16		pru mii 1 txclk		pwm 1 tripzone		gpio 1.16		P9.15
gpmc a1			mii 1 rxdv		rgmii 1 rxctl		mmc 2 d0		gpmc a17		pru mii 1 txd3		pwm sync out		gpio 1.17		P9.23
gpmc a2			mii 1 txd3		rgmii 1 txd3		mmc 2 d1		gpmc a18		pru mii 1 txd2		pwm 1 out A		gpio 1.18		P9.14
gpmc a3			mii 1 txd2		rgmii 1 txd2		mmc 2 d2		gpmc a19		pru mii 1 txd1		pwm 1 out B		gpio 1.19		P9.16
gpmc a4			mii 1 txd1		rgmii 1 txd1		rmii 1 txd1		gpmc a20		pru mii 1 txd0		qep 1 in A		gpio 1.20		eMMC reset
gpmc a5			mii 1 txd0		rgmii 1 txd0		rmii 1 txd0		gpmc a21		pru mii 1 rxd3		qep 1 in B		gpio 1.21		user led 0
gpmc a6			mii 1 txclk		rgmii 1 txclk		mmc 2 d4		gpmc a22		pru mii 1 rxd2		qep 1 index		gpio 1.22		user led 1
gpmc a7			mii 1 rxclk		rgmii 1 rxclk		mmc 2 d5		gpmc a23		pru mii 1 rxd1		qep 1 strobe		gpio 1.23		user led 2
gpmc a8			mii 1 rxd3		rgmii 1 rxd3		mmc 2 d6		gpmc a24		pru mii 1 rxd0		asp 0 tx clk		gpio 1.24		user led 3
gpmc a9			mii 1 rxd2		rgmii 1 rxd2		mmc 2 d7		gpmc a25		pru mii 1 rxclk		asp 0 tx fs		gpio 1.25		hdmi irq
gpmc a10		mii 1 rxd1		rgmii 1 rxd1		rmii 1 rxd1		gpmc a26		pru mii 1 rxdv		asp 0 data 0		gpio 1.26		usb A vbus overcurrent
gpmc a11		mii 1 rxd0		rgmii 1 rxd0		rmii 1 rxd0		gpmc a27		pru mii 1 rxer		asp 0 data 1		gpio 1.27		audio osc enable
gpmc wait 0		mii 1 crs		gpmc c̅s̅ 4		rmii 1 crs/rxdv		mmc 1 cd		pru mii 1 col		uart 4 rxd		gpio 0.30		P9.11
gpmc w̅p̅			mii 1 rxer		gpmc c̅s̅ 5		rmii 1 rxer		mmc 2 cd		pru mii 1 txen		uart 4 txd		gpio 0.31		P9.13
gpmc b̅e̅1		mii 1 col		gpmc c̅s̅ 6		mmc 2 d3		gpmc dir		pru mii 1 rxlink	asp 0 rx clk		gpio 1.28		P9.12
gpmc c̅s̅ 0		-			-			-			-			-			-			gpio 1.29		P8.26
gpmc c̅s̅ 1		gpmc clk		mmc 1 clk		pru edio in 6 {0}	pru edio out 6 {0}	pru 1 out 12		pru 1 in 12		gpio 1.30		P8.21 / eMMC clk
gpmc c̅s̅ 2		gpmc b̅e̅1		mmc 1 cmd		pru edio in 7 {0}	pru edio out 7 {0}	pru 1 out 13		pru 1 in 13		gpio 1.31		P8.20 / eMMC cmd
gpmc c̅s̅ 3		gpmc a3			rmii 1 crs/rxdv		mmc 2 cmd		pru mii 0 crs		pru mdio data		jtag emu 4		gpio 2.00		P9.15
gpmc clk		lcd mclk		gpmc wait 1		mmc 2 clk		pru mii 1 crs		pru mdio clock		asp 0 rx fs		gpio 2.01		P8.18
gpmc a̅d̅v̅ / ale		-			timer 4			-			-			-			-			gpio 2.02		P8.07
gpmc o̅e̅ / r̅e̅		-			timer 7			-			-			-			-			gpio 2.03		P8.08
gpmc w̅e̅			-			timer 6			-			-			-			-			gpio 2.04		P8.10
gpmc b̅e̅0 / cle		-			timer 5			-			-			-			-			gpio 2.05		P8.09
lcd d0			gpmc a0			pru mii 0 txclk		pwm 2 out A		-			pru 1 out 0		pru 1 in 0		gpio 2.06		P8.45 / hdmi / sysboot 0
lcd d1			gpmc a1			pru mii 0 txen		pwm 2 out B		-			pru 1 out 1		pru 1 in 1		gpio 2.07		P8.46 / hdmi / sysboot 1
lcd d2			gpmc a2			pru mii 0 txd3		pwm 2 tripzone		-			pru 1 out 2		pru 1 in 2		gpio 2.08		P8.43 / hdmi / sysboot 2
lcd d3			gpmc a3			pru mii 0 txd2		pwm sync out		-			pru 1 out 3		pru 1 in 3		gpio 2.09		P8.44 / hdmi / sysboot 3
lcd d4			gpmc a4			pru mii 0 txd1		qep 2 in A		-			pru 1 out 4		pru 1 in 4		gpio 2.10		P8.41 / hdmi / sysboot 4
lcd d5			gpmc a5			pru mii 0 txd0		qep 2 in B		-			pru 1 out 5		pru 1 in 5		gpio 2.11		P8.42 / hdmi / sysboot 5
lcd d6			gpmc a6			pru edio in 6 {1}	qep 2 index		pru edio out 6 {1}	pru 1 out 6		pru 1 in 6		gpio 2.12		P8.39 / hdmi / sysboot 6
lcd d7			gpmc a7			pru edio in 7 {1}	qep 2 strobe		pru edio out 7 {1}	pru 1 out 7		pru 1 in 7		gpio 2.13		P8.40 / hdmi / sysboot 7
lcd d8			gpmc a12		pwm 1 tripzone		asp 0 tx clk		uart 5 txd		pru mii 0 rxd3		uart 2 c̅t̅s̅		gpio 2.14		P8.37 / hdmi / sysboot 8
lcd d9			gpmc a13		pwm sync out		asp 0 tx fs		uart 5 rxd		pru mii 0 rxd2		uart 2 r̅t̅s̅		gpio 2.15		P8.38 / hdmi / sysboot 9
lcd d10			gpmc a14		pwm 1 out A		asp 0 data 0		-			pru mii 0 rxd1		uart 3 c̅t̅s̅		gpio 2.16		P8.36 / hdmi / sysboot 10
lcd d11			gpmc a15		pwm 1 out B		asp 0 rx hclk		asp 0 data 2		pru mii 0 rxd0		uart 3 r̅t̅s̅		gpio 2.17		P8.34 / hdmi / sysboot 11
lcd d12			gpmc a16		qep 1 in A		asp 0 rx clk		asp 0 data 2		pru mii 0 rxlink	uart 4 c̅t̅s̅		gpio 0.08		P8.35 / hdmi / sysboot 12
lcd d13			gpmc a17		qep 1 in B		asp 0 rx fs		asp 0 data 3		pru mii 0 rxer		uart 4 r̅t̅s̅		gpio 0.09		P8.33 / hdmi / sysboot 13
lcd d14			gpmc a18		qep 1 index		asp 0 data 1		uart 5 rxd		pru mii 0 rxclk		uart 5 c̅t̅s̅		gpio 0.10		P8.31 / hdmi / sysboot 14
lcd d15			gpmc a19		qep 1 strobe		asp 0 tx hclk		asp 0 data 3		pru mii 0 rxdv		uart 5 r̅t̅s̅		gpio 0.11		P8.32 / hdmi / sysboot 15
lcd vsync		gpmc a8			gpmc a1			pru edio in 2		pru edio out 2		pru 1 out 8		pru 1 in 8		gpio 2.22		P8.27 / hdmi
lcd hsync		gpmc a9			gpmc a2			pru edio in 3		pru edio out 3		pru 1 out 9		pru 1 in 9		gpio 2.23		P8.29 / hdmi
lcd pclk		gpmc a10		pru mii 0 crs		pru edio in 4		pru edio out 4		pru 1 out 10		pru 1 in 10		gpio 2.24		P8.28 / hdmi
lcd oe/acb		gpmc a11		pru mii 1 crs		pru edio in 5		pru edio out 5		pru 1 out 11		pru 1 in 11		gpio 2.25		P8.30 / hdmi
mmc 0 d3		gpmc a20		uart 4 c̅t̅s̅		timer 5			uart 1 d̅c̅d̅		pru 0 out 8		pru 0 in 8		gpio 2.26		μSD d3
mmc 0 d2		gpmc a21		uart 4 r̅t̅s̅		timer 6			uart 1 d̅s̅r̅		pru 0 out 9		pru 0 in 9		gpio 2.27		μSD d2
mmc 0 d1		gpmc a22		uart 5 c̅t̅s̅		uart 3 rxd		uart 1 d̅t̅r̅		pru 0 out 10		pru 0 in 10		gpio 2.28		μSD d1
mmc 0 d0		gpmc a23		uart 5 r̅t̅s̅		uart 3 txd		uart 1 r̅i̅		pru 0 out 11		pru 0 in 11		gpio 2.29		μSD d0
mmc 0 clk		gpmc a24		uart 3 c̅t̅s̅		uart 2 rxd		can 1 tx {2}		pru 0 out 12		pru 0 in 12		gpio 2.30		μSD clk
mmc 0 cmd		gpmc a25		uart 3 r̅t̅s̅		uart 2 txd		can 1 rx {2}		pru 0 out 13		pru 0 in 13		gpio 2.31		μSD cmd
mii 0 col		rmii 1 refclk		spi 1 clk		uart 5 rxd		asp 1 data 2		mmc 2 d3		asp 0 data 2		gpio 3.00		eth mii col
mii 0 crs		rmii 0 crs/rxdv		spi 1 data 0		I²C 1 sda {0}		asp 1 tx clk		uart 5 c̅t̅s̅		uart 2 rxd		gpio 3.01		eth mii crs
mii 0 rxer		rmii 0 rxer		spi 1 data 1		I²C 1 scl {0}		asp 1 tx fs		uart 5 r̅t̅s̅		uart 2 txd		gpio 3.02		eth mii rx err
mii 0 txen		rmii 0 txen		rgmii 0 txctl		timer 4			asp 1 data 0		qep 0 index		mmc 2 cmd		gpio 3.03		eth mii tx en
mii 0 rxdv		lcd mclk		rgmii 0 rxctl		uart 5 txd		asp 1 tx clk		mmc 2 d0		asp 0 rx clk		gpio 3.04		eth mii rx dv
mii 0 txd3		can 0 tx {0}		rgmii 0 txd3		uart 4 rxd		asp 1 tx fs		mmc 2 d1		asp 0 rx fs		gpio 0.16		eth mii tx d3
mii 0 txd2		can 0 rx {0}		rgmii 0 txd2		uart 4 txd		asp 1 data 0		mmc 2 d2		asp 0 tx hclk		gpio 0.17		eth mii tx d2
mii 0 txd1		rmii 0 txd1		rgmii 0 txd1		asp 1 rx fs		asp 1 data 1		qep 0 in A		mmc 1 cmd		gpio 0.21		eth mii tx d1
mii 0 txd0		rmii 0 txd0		rgmii 0 txd0		asp 1 data 2		asp 1 rx clk		qep 0 in B		mmc 1 clk		gpio 0.28		eth mii tx d0
mii 0 txclk		uart 2 rxd		rgmii 0 txclk		mmc 0 d7		mmc 1 d0		uart 1 d̅c̅d̅		asp 0 tx clk		gpio 3.09		eth mii tx clk
mii 0 rxclk		uart 2 txd		rgmii 0 rxclk		mmc 0 d6		mmc 1 d1		uart 1 d̅s̅r̅		asp 0 tx fs		gpio 3.10		eth mii rx clk
mii 0 rxd3		uart 3 rxd		rgmii 0 rxd3		mmc 0 d5		mmc 1 d2		uart 1 d̅t̅r̅		asp 0 data 0		gpio 2.18		eth mii rx d3
mii 0 rxd2		uart 3 txd		rgmii 0 rxd2		mmc 0 d4		mmc 1 d3		uart 1 r̅i̅		asp 0 data 1		gpio 2.19		eth mii rx d2
mii 0 rxd1		rmii 0 rxd1		rgmii 0 rxd1		asp 1 data 3		asp 1 rx fs		qep 0 strobe		mmc 2 clk		gpio 2.20		eth mii rx d1
mii 0 rxd0		rmii 0 rxd0		rgmii 0 rxd0		asp 1 tx hclk		asp 1 rx hclk		asp 1 rx clk		asp 0 data 3		gpio 2.21		eth mii rx d0
rmii 0 refclk		dma event 2		spi 1 c̅s̅ 0		uart 5 txd		asp 1 data 3		mmc 0 pow		asp 1 tx hclk		gpio 0.29		-eth unused
mdio data		timer 6			uart 5 rxd		uart 3 c̅t̅s̅		mmc 0 cd		mmc 1 cmd		mmc 2 cmd		gpio 0.00		eth mdio
mdio clk		timer 5			uart 5 txd		uart 3 r̅t̅s̅		mmc 0 wp		mmc 1 clk		mmc 2 clk		gpio 0.01		eth mdc
spi 0 clk		uart 2 rxd		I²C 2 sda {2}		pwm 0 out A		uart pru c̅t̅s̅		pru edio sof		jtag emu 2 {1}		gpio 0.02		P9.22 / spi boot clk
spi 0 data 0		uart 2 txd		I²C 2 scl {2}		pwm 0 out B		uart pru r̅t̅s̅		pru edio latch		jtag emu 3 {1}		gpio 0.03		P9.21 / spi boot in
spi 0 data 1		mmc 1 wp		I²C 1 sda {3}		pwm 0 tripzone		uart pru rxd		pru edio in 0		pru edio out 0		gpio 0.04		P9.18 / spi boot out
spi 0 c̅s̅ 0		mmc 2 wp		I²C 1 scl {3}		pwm sync in		uart pru txd		pru edio in 1		pru edio out 1		gpio 0.05		P9.17 / spi boot cs
spi 0 c̅s̅ 1		uart 3 rxd		eCAP 1			mmc 0 pow		dma event 2		mmc 0 cd		jtag emu 4 {0,1}	gpio 0.06		μSD cd / jtag emu4
eCAP 0			uart 3 txd		spi 1 c̅s̅ 1		pru eCAP		spi 1 clk		mmc 0 wp		dma event 2		gpio 0.07		P9.42
uart 0 c̅t̅s̅		uart 4 rxd		can 1 tx {0}		I²C 1 sda {1}		spi 1 data 0		timer 7			pru edc sync 0 out	gpio 1.08		-×
uart 0 r̅t̅s̅		uart 4 txd		can 1 rx {0}		I²C 1 scl {1}		spi 1 data 1		spi 1 c̅s̅ 0		pru edc sync 1 out	gpio 1.09		-TP9
uart 0 rxd		spi 1 c̅s̅ 0		can 0 tx {1}		I²C 2 sda {1}		eCAP 2			pru 1 out 14		pru 1 in 14		gpio 1.10		console in
uart 0 txd		spi 1 c̅s̅ 1		can 0 rx {1}		I²C 2 scl {1}		eCAP 1			pru 1 out 15		pru 1 in 15		gpio 1.11		console out
uart 1 c̅t̅s̅		timer 6			can 0 tx {2}		I²C 2 sda {0}		spi 1 c̅s̅ 0		uart pru c̅t̅s̅		pru edc latch 0		gpio 0.12		P9.20 / cape I²C sda
uart 1 r̅t̅s̅		timer 5			can 0 rx {2}		I²C 2 scl {0}		spi 1 c̅s̅ 1		uart pru r̅t̅s̅		pru edc latch 1		gpio 0.13		P9.19 / cape I²C scl
uart 1 rxd		mmc 1 wp		can 1 tx {1}		I²C 1 sda {2}		-			uart pru rxd		pru 1 in 16		gpio 0.14		P9.26
uart 1 txd		mmc 2 wp		can 1 rx {1}		I²C 1 scl {2}		-			uart pru txd		pru 0 in 16		gpio 0.15		P9.24
I²C 0 sda		timer 4			uart 2 c̅t̅s̅		eCAP 2			-			-			-			gpio 3.05		local I²C sda
I²C 0 scl		timer 7			uart 2 r̅t̅s̅		eCAP 1			-			-			-			gpio 3.06		local I²C scl
asp 0 tx clk		pwm 0 out A		-			spi 1 clk		mmc 0 cd		pru 0 out 0		pru 0 in 0		gpio 3.14		P9.31 / hdmi audio clk
asp 0 tx fs		pwm 0 out B		-			spi 1 data 0		mmc 1 cd		pru 0 out 1		pru 0 in 1		gpio 3.15		P9.29 / hdmi audio fs
asp 0 data 0		pwm 0 tripzone		-			spi 1 data 1		mmc 2 cd		pru 0 out 2		pru 0 in 2		gpio 3.16		P9.30
asp 0 rx hclk		pwm sync in		asp 0 data 2		spi 1 c̅s̅ 0		eCAP 2			pru 0 out 3		pru 0 in 3		gpio 3.17		P9.28 / hdmi audio data
asp 0 rx clk		qep 0 in A		asp 0 data 2		asp 1 tx clk		mmc 0 wp		pru 0 out 4		pru 0 in 4		gpio 3.18		P9.42
asp 0 rx fs		qep 0 in B		asp 0 data 3		asp 1 tx fs		jtag emu 2 {2}		pru 0 out 5		pru 0 in 5		gpio 3.19		P9.27
asp 0 data 1		qep 0 index		-			asp 1 data 0		jtag emu 3 {2}		pru 0 out 6		pru 0 in 6		gpio 3.20		P9.41
asp 0 tx hclk		qep 0 strobe		asp 0 data 3		asp 1 data 1		jtag emu 4 {2,3}	pru 0 out 7		pru 0 in 7		gpio 3.21		P9.25 / audio osc
dma event 0		-			timer 4			clkout 0		spi 1 c̅s̅ 1		pru 1 in 16		jtag emu 2 {0,3}	gpio 0.19		hdmi cec / jtag emu2
dma event 1		-			timer clkin		clkout 1		timer 7			pru 0 in 16		jtag emu 3 {0,3}	gpio 0.20		P9.41 / jtag emu3
r̅e̅s̅e̅t̅ in/out		-			-			-			-			-			-			-			-reset
p̅o̅r̅			-			-			-			-			-			-			-			-pmic
mpu i̅r̅q̅			-			-			-			-			-			-			-			pmic irq
osc 0 in		-			-			-			-			-			-			-			-xtal
osc 0 out		-			-			-			-			-			-			-			-xtal
osc 0 gnd		-			-			-			-			-			-			-			-xtal
jtag tms		-			-			-			-			-			-			-			-jtag
jtag tdi		-			-			-			-			-			-			-			-jtag
jtag tdo		-			-			-			-			-			-			-			-jtag
jtag tck		-			-			-			-			-			-			-			-jtag
jtag t̅r̅s̅t̅		-			-			-			-			-			-			-			-jtag
emu 0			-			-			-			-			-			-			gpio 3.07		jtag emu0
emu 1			-			-			-			-			-			-			gpio 3.08		jtag emu1
osc 1 (rtc) in		-			-			-			-			-			-			-			-rtc xtal
osc 1 (rtc) out		-			-			-			-			-			-			-			-rtc xtal
rtc gnd			-			-			-			-			-			-			-			-rtc xtal
rtc p̅o̅r̅			-			-			-			-			-			-			-			-pmic
power en		-			-			-			-			-			-			-			-pmic
wakeup			-			-			-			-			-			-			-			-pmic
rtc ldo e̅n̅		-			-			-			-			-			-			-			-pmic
usb 0 d−		-			-			-			-			-			-			-			-usb B
usb 0 d+		-			-			-			-			-			-			-			-usb B
usb 0 charge en		-			-			-			-			-			-			-			-x
usb 0 id		-			-			-			-			-			-			-			-usb B id
usb 0 vbus in		-			-			-			-			-			-			-			-usb B vbus
usb 0 vbus out en	-			-			-			-			-			-			gpio 0.18		-×
usb 1 d−		-			-			-			-			-			-			-			-usb A
usb 1 d+		-			-			-			-			-			-			-			-usb A
usb 1 charge en		-			-			-			-			-			-			-			-×
usb 1 id		-			-			-			-			-			-			-			-gnd
usb 1 vbus in		-			-			-			-			-			-			-			-usb A vbus
usb 1 vbus out en	-			-			-			-			-			-			gpio 3.13		usb A vbus en
# vim: ts=8:sts=0:noet:nowrap

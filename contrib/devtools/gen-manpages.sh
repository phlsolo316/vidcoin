#!/usr/bin/env bash
# Copyright (c) 2016-2019 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

VIDCOIND=${VIDCOIND:-$BINDIR/vidcoind}
VIDCOINCLI=${VIDCOINCLI:-$BINDIR/vidcoin-cli}
VIDCOINTX=${VIDCOINTX:-$BINDIR/vidcoin-tx}
WALLET_TOOL=${WALLET_TOOL:-$BINDIR/vidcoin-wallet}
VIDCOINQT=${VIDCOINQT:-$BINDIR/qt/vidcoin-qt}

[ ! -x $VIDCOIND ] && echo "$VIDCOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
read -r -a VIDVER <<< "$($VIDCOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }')"

# Create a footer file with copyright content.
# This gets autodetected fine for vidcoind if --version-string is not set,
# but has different outcomes for vidcoin-qt and vidcoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$VIDCOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $VIDCOIND $VIDCOINCLI $VIDCOINTX $WALLET_TOOL $VIDCOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${VIDVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${VIDVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m

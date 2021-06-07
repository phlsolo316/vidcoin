// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef VIDCOIN_QT_VIDCOINADDRESSVALIDATOR_H
#define VIDCOIN_QT_VIDCOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class VIDCoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit VIDCoinAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

/** VIDCoin address widget validator, checks for a valid vidcoin address.
 */
class VIDCoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit VIDCoinAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

#endif // VIDCOIN_QT_VIDCOINADDRESSVALIDATOR_H

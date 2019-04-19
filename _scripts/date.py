#!/usr/bin/env python3

class DateError(Exception):
    pass

MONTH_NAMES = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
               'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

def neat_date(date):
    """Turns an ISO date into a good respectable short British date

    Examples:
    >>> neat_date('1991-04-19')
    '19 Apr 1991'
    >>> neat_date('1975-03-05')
    '5 Mar 1975'
    >>> neat_date('1987-08-25')
    '25 Aug 1987'
    >>> neat_date('0814-01-28')
    '28 Jan 814'
    >>> neat_date('12-25')
    '25 Dec'
    >>> neat_date('04')
    '4'
    >>> neat_date('')
    ''
    >>> neat_date('2015-04-12/15')
    '12--15 Apr 2015'
    >>> neat_date('2016-05-30/06-01')
    '30 May--1 Jun 2016'
    >>> neat_date('1509-04-22/1547-01-28')
    '22 Apr 1509--28 Jan 1547'
    >>> neat_date('2018-10-01 2018-02-20 2017-10-02 2017-09-18')
    '1 Oct 2018, 20 Feb 2018, 2 Oct 2017, 18 Sep 2017'

    """

    if len(date.split(' ')) > 1:
        return ', '.join([neat_date(d) for d in date.split(' ')])

    def get_comps(iso_date):
        if iso_date == '':
            return None, None, None
        components = iso_date.split('-')
        if len(components) > 3 or len(components) < 1:
            raise DateError(iso_date)

        d,m,y = None, None, None
        d = int(components[-1])
        if len(components) > 1:
            m = int(components[-2])
        if len(components) > 2:
            y = int(components[-3])
        return d, m, y

    dates = date.split('/')
    if len(dates) == 0:
        return ''
    elif len(dates) == 1:
        d1, m1, y1 = None, None, None
    elif len(dates) == 2:
        d1, m1, y1 = get_comps(dates[1])
    elif len(dates) > 2:
        raise DateError(date)

    d0, m0, y0 = get_comps(dates[0])
    
    string = ''
    if d0:
        string += str(d0)
        if d1 and not m1:
            string += '--' + str(d1)
    if m0:
        string += ' ' + MONTH_NAMES[m0-1]
        if m1 and not y1:
            string += '--' + str(d1) + ' ' + MONTH_NAMES[m1-1]
    if y0:
        string += ' ' + str(y0)
        if y1:
            string += '--' + str(d1) + ' ' + MONTH_NAMES[m1-1] + ' ' + str(y1)

    return string

from sys import argv, stdin

if __name__ == '__main__':
    for date in argv[1:]:
        print(neat_date(date))
    print(neat_date(stdin.readlines()[0]))

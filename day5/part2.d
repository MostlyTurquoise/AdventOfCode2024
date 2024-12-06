module day5.part2;

void main() @safe
{
    import std.stdio;
    import std.string;
    import std.conv : parse;
    import std.algorithm : canFind, remove;

    writeln("Started :)");
    File inputf = File("input.txt", "r");
    bool loadingRules = true;

    int[][int] pagesBefore;
    int sum = 0;

    while (!inputf.eof())
    {
        string line = strip(inputf.readln());
        if (line.length == 0 && loadingRules)
        {
            loadingRules = false;
            continue;
        }
        if (loadingRules)
        {
            string[] spl = line.split("|");
            int before = parse!int(spl[0]);
            int after = parse!int(spl[1]);
            pagesBefore[after] ~= before;
        }
        else
        {
            bool toPrint = true;
            string[] pagess = line.split(",");
            int[] pages;
            foreach (i, v; pagess)
            {
                pages ~= parse!int(v);
            }
            for (int i = cast(int) pages.length - 1; i > 0; i--)
            {
                for (int ii = i; ii < cast(int) pages.length; ii++)
                {
                    if (pagesBefore[pages[i]].canFind(pages[ii]))
                    {
                        toPrint = false;
                    }
                }
            }
            if (toPrint)
            {
                // If it doesnt 
                // sum += pages[$/2];
            }
            else
            {
                int[] correct;
                while (pages.length > 0)
                {
                    for (int i = 0; i < cast(int) pages.length; i++)
                    {
                        writeln("checking ",i," ",pages[i]);
                        bool valid = true;
                        for (int j = 0; j < cast(int) pages.length; j++)
                        {
                            if (j == i)
                                continue;
                            if (!pagesBefore[pages[j]].canFind(pages[i]))
                                valid = false;
                        }
                        if (valid)
                        {
                            correct ~= pages[i];
                            pages.remove(i);
                            i--;
                            pages.length--;
                        }
                        writeln("Current correct:");
                        foreach (s, n; correct)
                        {
                            write(n," ");
                        }
                        writeln("");
                        writeln("Current pages:");
                        foreach (s, n; pages)
                        {
                            write(n," ");
                        }
                        writeln("");
                    }
                }
                sum += correct[$ / 2];
            }
        }
    }
    writeln(sum);
}
